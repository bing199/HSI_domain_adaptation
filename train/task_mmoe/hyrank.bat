call "E:\zts\software\Anaconda\Scripts\activate.bat" zts
cd E:\zts\HSI_domain_adaptation
set PYTHONPATH=%cd%

rem mmoe-ddc
python train/task_mmoe/train_ddc.py configs/hyrank/task_mmoe/task_mmoe_fe_ddc.yaml ^
        --path ./runs/hyrank/task_mmoe/task_mmoe_fe_ddc-train ^
        --nodes 1 ^
        --gpus 1 ^
        --rank-node 0 ^
        --backend gloo ^
        --master-ip localhost ^
        --master-port 8890 ^
        --seed %~1% ^
        --opt-level O0

rem mmoe-dan
python train/task_mmoe/train_ddc.py configs/hyrank/task_mmoe/task_mmoe_fe_dan.yaml ^
        --path ./runs/hyrank/task_mmoe/task_mmoe_fe_dan-train ^
        --nodes 1 ^
        --gpus 1 ^
        --rank-node 0 ^
        --backend gloo ^
        --master-ip localhost ^
        --master-port 8890 ^
        --seed %~1% ^
        --opt-level O0

rem mmoe-jan
python train/task_mmoe/train_ddc.py configs/hyrank/task_mmoe/task_mmoe_fe_jan.yaml ^
        --path ./runs/hyrank/task_mmoe/task_mmoe_fe_jan-train ^
        --nodes 1 ^
        --gpus 1 ^
        --rank-node 0 ^
        --backend gloo ^
        --master-ip localhost ^
        --master-port 8890 ^
        --seed %~1% ^
        --opt-level O0

rem mmoe-dann
python train/task_mmoe/train_dann.py configs/hyrank/task_mmoe/task_mmoe_fe_dann.yaml ^
        --path ./runs/hyrank/task_mmoe/task_mmoe_fe_dann-train ^
        --nodes 1 ^
        --gpus 1 ^
        --rank-node 0 ^
        --backend gloo ^
        --master-ip localhost ^
        --master-port 8890 ^
        --seed %~1% ^
        --opt-level O0

rem mmoe-self_training
python train/task_mmoe/train_self_training.py configs/hyrank/task_mmoe/task_mmoe_fe_self_training_08.yaml ^
        --path ./runs/hyrank/task_mmoe/task_mmoe_fe_self_training_08-train ^
        --nodes 1 ^
        --gpus 1 ^
        --rank-node 0 ^
        --backend gloo ^
        --master-ip localhost ^
        --master-port 8890 ^
        --seed %~1% ^
        --opt-level O0