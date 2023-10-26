call "E:\zts\software\Anaconda\Scripts\activate.bat" zts
cd E:\zts\HSI_domain_adaptation
set PYTHONPATH=%cd%

rem hma
python train/hma/train_ddc.py configs/houston/hma/hma_dan_3.yaml ^
        --path ./runs/houston/hma_dan-train ^
        --nodes 1 ^
        --gpus 1 ^
        --rank-node 0 ^
        --backend gloo ^
        --master-ip localhost ^
        --master-port 8882 ^
        --seed %~1% ^
        --opt-level O1

rem hma
python train/hma/train_dann.py configs/houston/hma/hma_dann_3.yaml ^
        --path ./runs/houston/hma_dann-train ^
        --nodes 1 ^
        --gpus 1 ^
        --rank-node 0 ^
        --backend gloo ^
        --master-ip localhost ^
        --master-port 8882 ^
        --seed %~1% ^
        --opt-level O1

