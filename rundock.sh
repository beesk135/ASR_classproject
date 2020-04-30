#!/bin/bash
# docker run -it -v /c/Users/beebe/Desktop/ME_3_TERM_2/TASK_ASR/ASR_classproject/:/ASR_project burin010n/kaldi /bin/bash
# docker run -it -v /Users/yotsatorn/Project/onProcessProject/ASR/ASR_classproject/:/ASR_project burin010n/kaldi /bin/bash
# docker exec -it cc761932b7ee /bin/bash
cp /ASR_project/scripts/prepare_LG.sh /kaldi/egs/librispeech/s5/
cp /ASR_project/scripts/AM_chain.zip /kaldi/egs/librispeech/s5/
cd /kaldi/egs/librispeech/s5/
unzip AM_chain.zip 
chmod u+x prepare_LG.sh 
./prepare_LG.sh /ASR_project/g2p/g2plex.txt /ASR_project/lm/arpa.lm  exp/chain/tree_a_sp/phones.txt data/lcoal/dict data/lang

utils/mkgraph.sh \
  --self-loop-scale 1.0 data/lang \
  exp/chain/tree_a_sp exp/chain/tree_a_sp/graph

steps/online/nnet3/decode.sh --acwt 1.0 --post-decode-acwt 10.0 --nj 1 exp/chain/tree_a_sp/graph /ASR_project/data/test exp/chain/tdnn1r_sp_online/decode_dev
cp -r /ASR_project/waves/ /kaldi/egs/librispeech/s5/waves