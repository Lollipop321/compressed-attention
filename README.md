# Compressed Attention Network (CAN)

## Requirements

pytorch >= 1.0, python >= 3.6.0, cuda >= 9.2

## How to Reproduce

To reproduce the WMT14 experiments, please run:

    # train the wmt14 models
    sh train_wmt14.sh
    # translate and score on the test sets
    sh translate_wmt14.sh

To reproduce the WMT17 experiments, please run:

    # train the wmt17 models
    sh train_wmt17.sh
    # translate and score on the test sets
    sh translate_wmt17.sh

## Implementations

The code files that implements CAN are located in:

1. Compressed-Attention: `fairseq/modules/compressed_sublayer.py`
2. CAN: `fairseq/models/can_transformer.py`
