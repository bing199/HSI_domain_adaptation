import torch
import torch.nn as nn

from typing import List

from models.modules import Gate


class FEMMOEMCD(nn.Module):
    def __init__(self, num_classes: int, experts: List[nn.Module]):
        super(FEMMOEMCD, self).__init__()
        # backbone输入通道数
        self.num_channels = experts[0].in_channels
        self.num_task = 2  # source domain and target domain
        self.num_classes = num_classes
        self.experts = nn.ModuleList(experts)
        self.gates = nn.ModuleList([Gate(self.num_channels, len(experts)) for _ in range(self.num_task)])

    def forward(self, x, task_ind):
        assert task_ind in [1, 2]  # 1 for source domain and 2 for target domain
        experts_features = [i(x) for i in self.experts]
        experts_features = torch.stack(experts_features, 1)
        experts_features = torch.squeeze(experts_features)

        if task_ind == 1:
            task_weight = self.gates[0](x)[-1].softmax(dim=1).unsqueeze(1)
        else:
            task_weight = self.gates[1](x)[-1].softmax(dim=1).unsqueeze(1)
        features = torch.matmul(task_weight, experts_features)
        features = features.squeeze(1)
        return features, task_weight
