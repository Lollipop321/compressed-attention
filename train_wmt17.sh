#! /usr/bin/bash
set -e

device=0,1,2,3,4,5,6,7

task=fi2en
#task=en2fi
task=lv2en
#task=en2lv
#task=ru2en
#task=en2ru
#task=cs2en
#task=en2cs
#task=de2en17
#task=en2de17

tag=can_el12_dl2

# must set this tag
tag=${task}"_"${tag}

if [ $task == "fi2en" ]; then
adam_betas="'(0.9, 0.997)'"
fi
if [ $task == "en2fi" ]; then
adam_betas="'(0.9, 0.997)'"
fi
if [ $task == "lv2en" ]; then
adam_betas="'(0.9, 0.997)'"
fi
if [ $task == "en2lv" ]; then
adam_betas="'(0.9, 0.997)'"
fi
if [ $task == "ru2en" ]; then
adam_betas="'(0.9, 0.997)'"
fi
if [ $task == "en2ru" ]; then
adam_betas="'(0.9, 0.997)'"
fi
if [ $task == "cs2en" ]; then
adam_betas="'(0.9, 0.997)'"
fi
if [ $task == "en2cs" ]; then
adam_betas="'(0.9, 0.997)'"
fi
if [ $task == "de2en17" ]; then
adam_betas="'(0.9, 0.997)'"
fi
if [ $task == "en2de17" ]; then
adam_betas="'(0.9, 0.997)'"
fi

if [ $task == "fi2en" ]; then
        arch=can_transformer_t2t_wmt_en_de_el12_dl2
        share_embedding=0
        share_decoder_input_output_embed=0
        fp16=1
        lr=0.001
        warmup=8000
        max_tokens=4096
        update_freq=1
        dropout=
        weight_decay=0.0
        label_smoothing=0.1
        seed=1
        keep_last_epochs=5
        max_epoch=15
        max_update=
        data_dir=wmt17_fi_en
        src_lang=fi
        tgt_lang=en
elif [ $task == "en2fi" ]; then
        arch=can_transformer_t2t_wmt_en_de_el12_dl2
        share_embedding=0
        share_decoder_input_output_embed=0
        fp16=1
        lr=0.001
        warmup=8000
        max_tokens=4096
        update_freq=1
        dropout=
        weight_decay=0.0
        label_smoothing=0.1
        seed=1
        keep_last_epochs=5
        max_epoch=15
        max_update=
        data_dir=wmt17_fi_en
        src_lang=en
        tgt_lang=fi
elif [ $task == "lv2en" ]; then
        arch=can_transformer_t2t_wmt_en_de_el12_dl2
        share_embedding=0
        share_decoder_input_output_embed=0
        fp16=1
        lr=0.001
        warmup=8000
        max_tokens=4096
        update_freq=1
        dropout=
        weight_decay=0.0
        label_smoothing=0.1
        seed=1
        keep_last_epochs=5
        max_epoch=15
        max_update=
        data_dir=wmt17_lv_en
        src_lang=lv
        tgt_lang=en
elif [ $task == "en2lv" ]; then
        arch=can_transformer_t2t_wmt_en_de_el12_dl2
        share_embedding=0
        share_decoder_input_output_embed=0
        fp16=1
        lr=0.001
        warmup=8000
        max_tokens=4096
        update_freq=1
        dropout=
        weight_decay=0.0
        label_smoothing=0.1
        seed=1
        keep_last_epochs=5
        max_epoch=15
        max_update=
        data_dir=wmt17_lv_en
        src_lang=en
        tgt_lang=lv
elif [ $task == "ru2en" ]; then
        arch=can_transformer_t2t_wmt_en_de_el12_dl2
        share_embedding=0
        share_decoder_input_output_embed=0
        fp16=1
        lr=0.001
        warmup=8000
        max_tokens=4096
        update_freq=1
        dropout=
        weight_decay=0.0
        label_smoothing=0.1
        seed=1
        keep_last_epochs=5
        max_epoch=10
        max_update=
        data_dir=wmt17_ru_en
        src_lang=ru
        tgt_lang=en
elif [ $task == "en2ru" ]; then
        arch=can_transformer_t2t_wmt_en_de_el12_dl2
        share_embedding=0
        share_decoder_input_output_embed=0
        fp16=1
        lr=0.001
        warmup=8000
        max_tokens=4096
        update_freq=1
        dropout=
        weight_decay=0.0
        label_smoothing=0.1
        seed=1
        keep_last_epochs=5
        max_epoch=10
        max_update=
        data_dir=wmt17_ru_en
        src_lang=en
        tgt_lang=ru
elif [ $task == "cs2en" ]; then
        arch=can_transformer_t2t_wmt_en_de_el12_dl2
        share_embedding=0
        share_decoder_input_output_embed=0
        fp16=1
        lr=0.001
        warmup=8000
        max_tokens=4096
        update_freq=1
        dropout=
        weight_decay=0.0
        label_smoothing=0.1
        seed=1
        keep_last_epochs=5
        max_epoch=10
        max_update=
        data_dir=wmt17_cs_en
        src_lang=cs
        tgt_lang=en
elif [ $task == "en2cs" ]; then
        arch=can_transformer_t2t_wmt_en_de_el12_dl2
        share_embedding=0
        share_decoder_input_output_embed=0
        fp16=1
        lr=0.001
        warmup=8000
        max_tokens=4096
        update_freq=1
        dropout=
        weight_decay=0.0
        label_smoothing=0.1
        seed=1
        keep_last_epochs=5
        max_epoch=10
        max_update=
        data_dir=wmt17_cs_en
        src_lang=en
        tgt_lang=cs
elif [ $task == "de2en17" ]; then
        arch=can_transformer_t2t_wmt_en_de_el12_dl2
        share_embedding=0
        share_decoder_input_output_embed=0
        fp16=1
        lr=0.001
        warmup=8000
        max_tokens=4096
        update_freq=1
        dropout=
        weight_decay=0.0
        label_smoothing=0.1
        seed=1
        keep_last_epochs=5
        max_epoch=21
        max_update=
        data_dir=wmt17_de_en
        src_lang=de
        tgt_lang=en
elif [ $task == "en2de17" ]; then
        arch=can_transformer_t2t_wmt_en_de_el12_dl2
        share_embedding=0
        share_decoder_input_output_embed=0
        fp16=1
        lr=0.001
        warmup=8000
        max_tokens=4096
        update_freq=1
        dropout=
        weight_decay=0.0
        label_smoothing=0.1
        seed=1
        keep_last_epochs=5
        max_epoch=21
        max_update=
        data_dir=wmt17_de_en
        src_lang=en
        tgt_lang=de
else
        echo "unknown task=$task"
        exit
fi

save_dir=output/$task/$tag

if [ ! -d $save_dir ]; then
        mkdir -p $save_dir
fi
cp ${BASH_SOURCE[0]} $save_dir/train.sh

gpu_num=`echo "$device" | awk '{split($0,arr,",");print length(arr)}'`

cmd="python3 -u train.py ../data-bin/$data_dir
  --distributed-world-size $gpu_num -s $src_lang -t $tgt_lang
  --arch $arch
  --save-interval-updates 10000
  --optimizer adam --clip-norm 0.0
  --lr-scheduler inverse_sqrt --warmup-init-lr 1e-07 --warmup-updates $warmup
  --lr $lr --min-lr 1e-09
  --criterion label_smoothed_cross_entropy --label-smoothing $label_smoothing
  --max-tokens $max_tokens
  --update-freq $update_freq
  --weight-decay $weight_decay
  --seed $seed
  --no-progress-bar
  --log-interval 100
  --ddp-backend no_c10d
  --save-dir $save_dir
  --keep-last-epochs $keep_last_epochs
  --tensorboard-logdir $save_dir"

cmd=${cmd}" --adam-betas "${adam_betas}

#--model-overrides "{}"

if [ $share_embedding -eq 1 ]; then
cmd=${cmd}" --share-all-embeddings "
fi

if [ $share_decoder_input_output_embed -eq 1 ]; then
cmd=${cmd}" --share-decoder-input-output-embed "
fi
if [ -n "$max_epoch" ]; then
cmd=${cmd}" --max-epoch "${max_epoch}
fi
if [ -n "$max_update" ]; then
cmd=${cmd}" --max-update "${max_update}
fi
if [ -n "$dropout" ]; then
cmd=${cmd}" --dropout "${dropout}
fi
if [ $fp16 -eq 1 ]; then
cmd=${cmd}" --fp16 "
fi

export CUDA_VISIBLE_DEVICES=$device
echo $cmd
cmd="nohup "${cmd}" >> $save_dir/train.log 2>&1 &"
eval $cmd
tail -f $save_dir/train.log
