#!/bin/bash
cd /kaldi/egs/wsj/s5/
pwd
source ./path.sh
cd /ASR_project/g2p
pwd
g2p.py --train dic5k.formatted.txt --devel 5% --encoding UTF-8 --write-model model-1
g2p.py --model model-1 --ramp-up --train dic5k.formatted.txt --devel 5% --encoding UTF-8 --write-model model-2
g2p.py --model model-2 --ramp-up --train dic5k.formatted.txt --devel 5% --encoding UTF-8 --write-model model-3
g2p.py --model model-3 --ramp-up --train dic5k.formatted.txt --devel 5% --encoding UTF-8 --write-model model-4
g2p.py --model model-4 --ramp-up --train dic5k.formatted.txt --devel 5% --encoding UTF-8 --write-model model-5
g2p.py --model model-5 --encoding UTF-8 --test dic5k.formatted.txt