call "E:\zts\software\Anaconda\Scripts\activate.bat" zts
cd E:\zts\HSI_domain_adaptation
set PYTHONPATH=%cd%

rem vdd_os
python train/vdd/train_os.py configs/houston/vdd/vdd_os.yaml ^
        --path ./runs/houston/vdd_os-train ^
        --nodes 1 ^
        --gpus 1 ^
        --rank-node 0 ^
        --backend gloo ^
        --master-ip localhost ^
        --master-port 8890 ^
        --seed %~1% ^
        --opt-level O1

rem vdd_ts
python train/vdd/train_ts.py configs/houston/vdd/vdd_ts.yaml ^
        --path ./runs/houston/vdd_ts-train ^
        --nodes 1 ^
        --gpus 1 ^
        --rank-node 0 ^
        --backend gloo ^
        --master-ip localhost ^
        --master-port 8890 ^
        --seed %~1% ^
        --opt-level O1

rem vdd_fixed_os
python train/vdd/train_os.py configs/houston/vdd/vdd_fixed_os.yaml ^
        --path ./runs/houston/vdd_fixed_os-train ^
        --nodes 1 ^
        --gpus 1 ^
        --rank-node 0 ^
        --backend gloo ^
        --master-ip localhost ^
        --master-port 8890 ^
        --seed %~1% ^
        --opt-level O1

rem vdd_fixed_ts
python train/vdd/train_ts.py configs/houston/vdd/vdd_fixed_ts.yaml ^
        --path ./runs/houston/vdd_fixed_ts-train ^
        --nodes 1 ^
        --gpus 1 ^
        --rank-node 0 ^
        --backend gloo ^
        --master-ip localhost ^
        --master-port 8890 ^
        --seed %~1% ^
        --opt-level O1


