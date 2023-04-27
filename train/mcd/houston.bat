call "E:\zts\software\Anaconda\Scripts\activate.bat" zts
cd E:\zts\HSI_domain_adaptation
set PYTHONPATH=%cd%

rem mcd
python train/mcd/train.py configs/houston/mcd/mcd.yaml ^
        --path ./runs/houston/mcd-train ^
        --nodes 1 ^
        --gpus 1 ^
        --rank-node 0 ^
        --backend gloo ^
        --master-ip localhost ^
        --master-port 8882 ^
        --seed %~1% ^
        --opt-level O2

rem mcd
python train/mcd/train.py configs/houston/mcd/mcd_1260_average.yaml ^
        --path ./runs/houston_sample/mcd-train ^
        --nodes 1 ^
        --gpus 1 ^
        --rank-node 0 ^
        --backend gloo ^
        --master-ip localhost ^
        --master-port 8882 ^
        --seed %~1% ^
        --opt-level O2