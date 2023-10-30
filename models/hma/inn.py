import torch
import torch.nn as nn

from tllib.modules.grl import GradientReverseLayer

from models.utils.init import initialize_weights
from models.backbone.classifier import ImageClassifier


class Block(nn.Module):
    def __init__(self, in_channels: int):
        super(Block, self).__init__()
        assert in_channels % 2 == 0
        mid_channels = int(in_channels / 2)
        self.relu = nn.LeakyReLU()

        self.F = nn.Sequential(
            nn.Conv2d(mid_channels, mid_channels, 1, 1, 0),
            nn.BatchNorm2d(mid_channels),
            self.relu,
        )
        self.G = nn.Sequential(
            nn.Conv2d(mid_channels, mid_channels, 1, 1, 0),
            nn.BatchNorm2d(mid_channels),
            self.relu,
        )

    def forward(self, x, reverse: bool = False):
        if reverse:
            x1, x2 = torch.chunk(x, 2, dim=1)
            y2 = x2 - self.G(x1)
            y1 = x1 - self.F(y2)
            y = torch.cat((y1, y2), dim=1)
        else:
            x1, x2 = torch.chunk(x, 2, dim=1)
            y1 = x1 + self.F(x2)
            y2 = x2 + self.G(y1)
            y = torch.cat((y1, y2), dim=1)
        return y


class INN(nn.Module):
    def __init__(self, in_channels: int, num_block: int):
        super(INN, self).__init__()
        assert num_block > 0
        self.blocks = nn.ModuleList([Block(in_channels) for _ in range(num_block)])
        initialize_weights(self.blocks)

    def forward(self, x, reverse: bool = False):
        # x = torch.squeeze(x)
        if reverse:
            for b in reversed(self.blocks):
                x = b(x, reverse=reverse)
        else:
            for b in self.blocks:
                x = b(x, reverse=reverse)
        return x


class INNDANN(INN):
    def __init__(self, in_channels: int, num_block: int):
        super(INNDANN, self).__init__(in_channels, num_block)
        self.grl = GradientReverseLayer()
        self.domain_discriminator = ImageClassifier(in_channels, 2)

    def forward(self, x, reverse: bool = False):
        # x = torch.squeeze(x)
        x_ = self.grl(x)
        out_domain1 = self.domain_discriminator(x_)[-1]
        if reverse:
            for b in reversed(self.blocks):
                x = b(x, reverse=reverse)
        else:
            for b in self.blocks:
                x = b(x, reverse=reverse)
        x_ = self.grl(x)
        out_domain2 = self.domain_discriminator(x_)[-1]
        return x, out_domain1, out_domain2
