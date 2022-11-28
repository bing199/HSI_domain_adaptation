call "E:\zts\software\Anaconda\Scripts\activate.bat" zts
cd E:\zts\HSI_domain_adaptation
set PYTHONPATH=%cd%

rem da_select
python train/da_select/train_dann_ct.py configs/houston/da_select.yaml ^
        --path ./runs/houston/da_select-train ^
        --nodes 1 ^
        --gpus 1 ^
        --rank-node 0 ^
        --backend gloo ^
        --master-ip localhost ^
        --master-port 8830 ^
        --seed %~1% ^
        --opt-level O2

python train/da_select/train_dann_ct_klv.py configs/houston/da_select.yaml ^
        --path ./runs/houston/da_select_ct_klv-train ^
        --nodes 1 ^
        --gpus 1 ^
        --rank-node 0 ^
        --backend gloo ^
        --master-ip localhost ^
        --master-port 8830 ^
        --seed 2 ^
        --opt-level O2