#!/usr/bin/bash
set -e

model_root_dir=output

# set task
#task=fi2en
#task=en2fi
#task=lv2en
#task=en2lv
#task=ru2en
#task=en2ru
#task=cs2en
task=en2cs
#task=de2en17
#task=en2de17

# set tag
model_dir_tag=en2cs_can_el12_dl2

# set device
gpu=0
cpu=

# data set
who=test
#who=valid

if [ $task == "fi2en" ]; then
        data_dir=wmt17_fi_en
        ensemble=5
        batch_size=64
        beam=4
        length_penalty=1.0
        src_lang=fi
        tgt_lang=en
        sacrebleu_set=
elif [ $task == "en2fi" ]; then
        data_dir=wmt17_fi_en
        ensemble=5
        batch_size=64
        beam=4
        length_penalty=1.0
        src_lang=en
        tgt_lang=fi
        sacrebleu_set=
elif [ $task == "lv2en" ]; then
        data_dir=wmt17_lv_en
        ensemble=5
        batch_size=64
        beam=4
        length_penalty=1.0
        src_lang=lv
        tgt_lang=en
        sacrebleu_set=
elif [ $task == "en2lv" ]; then
        data_dir=wmt17_lv_en
        ensemble=5
        batch_size=64
        beam=4
        length_penalty=1.0
        src_lang=en
        tgt_lang=lv
        sacrebleu_set=
elif [ $task == "ru2en" ]; then
        data_dir=wmt17_ru_en
        ensemble=5
        batch_size=64
        beam=4
        length_penalty=1.0
        src_lang=ru
        tgt_lang=en
        sacrebleu_set=
elif [ $task == "en2ru" ]; then
        data_dir=wmt17_ru_en
        ensemble=5
        batch_size=64
        beam=4
        length_penalty=1.0
        src_lang=en
        tgt_lang=ru
        sacrebleu_set=        
elif [ $task == "cs2en" ]; then
        data_dir=wmt17_cs_en
        ensemble=5
        batch_size=64
        beam=4
        length_penalty=1.0
        src_lang=cs
        tgt_lang=en
        sacrebleu_set=
elif [ $task == "en2cs" ]; then
        data_dir=wmt17_cs_en
        ensemble=5
        batch_size=64
        beam=4
        length_penalty=1.0
        src_lang=en
        tgt_lang=cs
        sacrebleu_set=
elif [ $task == "de2en17" ]; then
        data_dir=wmt17_de_en
        ensemble=5
        batch_size=64
        beam=4
        length_penalty=1.0
        src_lang=de
        tgt_lang=en
        sacrebleu_set=
elif [ $task == "en2de17" ]; then
        data_dir=wmt17_de_en
        ensemble=5
        batch_size=64
        beam=4
        length_penalty=1.0
        src_lang=en
        tgt_lang=de
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
--fp16 \
--gen-subset $who \
-s $src_lang -t $tgt_lang \
--batch-size $batch_size \
--beam $beam \
--lenpen $length_penalty \
--quiet \
--output $model_dir/hypo.txt \
--remove-bpe $use_cpu | tee $output

python3 rerank.py $model_dir/hypo.txt $model_dir/hypo.sorted

if [ $task == "fi2en" ]; then
./detokenizer.perl -l en < $model_dir/hypo.sorted > $model_dir/hypo.sorted.de
perl multi-bleu-detok.perl ref/fi2en/ref.en.de < $model_dir/hypo.sorted.de
fi
if [ $task == "en2fi" ]; then
./detokenizer.perl -l fi < $model_dir/hypo.sorted > $model_dir/hypo.sorted.de
perl multi-bleu-detok.perl ref/fi2en/ref.fi.de < $model_dir/hypo.sorted.de
fi
if [ $task == "lv2en" ]; then
./detokenizer.perl -l en < $model_dir/hypo.sorted > $model_dir/hypo.sorted.de
perl multi-bleu-detok.perl ref/lv2en/ref.en.de < $model_dir/hypo.sorted.de
fi
if [ $task == "en2lv" ]; then
./detokenizer.perl -l lv < $model_dir/hypo.sorted > $model_dir/hypo.sorted.de
perl multi-bleu-detok.perl ref/lv2en/ref.lv.de < $model_dir/hypo.sorted.de
fi
if [ $task == "ru2en" ]; then
./detokenizer.perl -l en < $model_dir/hypo.sorted > $model_dir/hypo.sorted.de
perl multi-bleu-detok.perl ref/ru2en/ref.en.de < $model_dir/hypo.sorted.de
fi
if [ $task == "en2ru" ]; then
./detokenizer.perl -l ru < $model_dir/hypo.sorted > $model_dir/hypo.sorted.de
perl multi-bleu-detok.perl ref/ru2en/ref.ru.de < $model_dir/hypo.sorted.de
fi
if [ $task == "cs2en" ]; then
./detokenizer.perl -l en < $model_dir/hypo.sorted > $model_dir/hypo.sorted.de
perl multi-bleu-detok.perl ref/cs2en/ref.en.de < $model_dir/hypo.sorted.de
fi
if [ $task == "en2cs" ]; then
./detokenizer.perl -l cs < $model_dir/hypo.sorted > $model_dir/hypo.sorted.de
perl multi-bleu-detok.perl ref/cs2en/ref.cs.de < $model_dir/hypo.sorted.de
fi
