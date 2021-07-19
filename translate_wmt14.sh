#!/usr/bin/bash
set -e

model_root_dir=output

# set task
task=wmt14_en2de
#task=wmt14_en2fr

# set tag
model_dir_tag=wmt14_en2de_can_el12_dl2

# set device
gpu=0
cpu=

# data set
who=test
#who=valid

if [ $task == "wmt14_en2de" ]; then
        data_dir=wmt14_en2de
        ensemble=5
        batch_size=64
        beam=4
        length_penalty=0.6
        src_lang=en
        tgt_lang=de
        sacrebleu_set=wmt14/full
elif [ $task == "wmt14_en2fr" ]; then
        data_dir=wmt14_en2fr
        ensemble=5
        batch_size=64
        beam=4
        length_penalty=0.7
        src_lang=en
        tgt_lang=fr
        sacrebleu_set=
else
        echo "unknown task=$task"
        exit
fi

model_dir=$model_root_dir/$task/$model_dir_tag

checkpoint=checkpoint_best.pt

if [ -n "$ensemble" ]; then
        if [ ! -e "$model_dir/last$ensemble.ensemble.pt" ]; then
                PYTHONPATH=`pwd` python3 scripts/average_checkpoints.py --inputs $model_dir --output $model_dir/last$ensemble.ensemble.pt --num-epoch-checkpoints $ensemble
        fi
        checkpoint=last$ensemble.ensemble.pt
fi

output=$model_dir/translation.log

if [ -n "$cpu" ]; then
        use_cpu=--cpu
fi

export CUDA_VISIBLE_DEVICES=$gpu

python3 generate.py \
../data-bin/$data_dir \
--path $model_dir/$checkpoint \
--gen-subset $who \
--batch-size $batch_size \
--beam $beam \
--lenpen $length_penalty \
--quiet \
--output $model_dir/hypo.txt \
--remove-bpe $use_cpu | tee $output

python3 rerank.py $model_dir/hypo.txt $model_dir/hypo.sorted
sh $get_ende_bleu $model_dir/hypo.sorted
