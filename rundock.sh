#!/bin/bash
# docker run -it -v /c/Users/beebe/Desktop/ME_3_TERM_2/TASK_ASR/ASR_classproject/:/ASR_project burin010n/kaldi /bin/bash
# docker run -it -v /Users/yotsatorn/Project/onProcessProject/ASR/ASR_classproject/:/ASR_project burin010n/kaldi /bin/bash
# docker exec -it cc761932b7ee /bin/bash
cp /ASR_project/scripts/prepare_LG.sh /kaldi/egs/librispeech/s5/
cp /ASR_project/scripts/AM_chain.zip /kaldi/egs/librispeech/s5/
cp -r /ASR_project/waves
cp -rf /ASR_project/data/ /kaldi/egs/librispeech/s5/data
cd /kaldi/egs/librispeech/s5/
unzip AM_chain.zip 
chmod u+x prepare_LG.sh 

sed -i -e 's/\r$//' prepare_LG.sh
prepare_LG.sh /ASR_project/g2p/g2plex.txt /ASR_project/lm/arpa.lm  exp/chain/tree_a_sp/phones.txt data/local/dict data/lang

utils/mkgraph.sh \
  --self-loop-scale 1.0 data/lang \
  exp/chain/tree_a_sp exp/chain/tree_a_sp/graph


DECODER
cp -rf /ASR_project/data/train /kaldi/egs/librispeech/s5/data/test
cp -rf /ASR_project/data/test /kaldi/egs/librispeech/s5/data/dev
steps/online/nnet3/decode.sh --acwt 1.0 --post-decode-acwt 10.0 --nj 1 exp/chain/tree_a_sp/graph data/dev exp/chain/tdnn1r_sp_online/decode_dev
steps/online/nnet3/decode.sh \          
  --acwt 1.0 --post-decode-acwt 10.0 --nj 4 \
  exp/chain/tree_a_sp/graph data/dev exp/chain/tdnn1p_sp_online/decode_dev

# cp -r /ASR_project/data/test/waves/ /kaldi/egs/librispeech/s5/data/testwaves
cp -r exp /ASR_project/exp
cp exp/chain/tree_a_sp/graph/HCLG.fst /ASR_project/model/graph/HCLG.fst
cp exp/chain/tree_a_sp/graph/words.txt /ASR_project/model/graph/words.txt
cp /kaldi/egs/librispeech/s5/exp/chain/tdnn1r_sp_online/tree /ASR_project/model/model/tree
cp /kaldi/egs/librispeech/s5/exp/chain/tdnn1r_sp_online/final.mdl /ASR_project/model/model/final.mdl
cp -r /kaldi/egs/librispeech/s5/exp/chain/tdnn1r_sp_online/conf/ /ASR_project/model/model/conf/
cp -r /kaldi/egs/librispeech/s5/exp/chain/tdnn1r_sp_online/ivector_extractor/ /ASR_project/model/model/ivector_extractor/

exit or creat new console 

cp -r .\ASR_classproject\model\ .\KaldiWebrtcServer\model

