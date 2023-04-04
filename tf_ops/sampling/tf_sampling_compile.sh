#/bin/bash
CUDA_HOME=/usr/local/cuda-11
TF_DIR=$(dirname $(python -c "import tensorflow as tf;print(tf.__file__)"))

${CUDA_HOME}/bin/nvcc tf_sampling_g.cu -o tf_sampling_g.cu.o -c -O2 -DGOOGLE_CUDA=1 -x cu -Xcompiler -fPIC

# TF1.2
g++ -std=c++11 tf_sampling.cpp tf_sampling_g.cu.o -o tf_sampling_so.so -shared -fPIC -I ${TF_DIR}/include -I ${CUDA_HOME}/include -lcudart -L ${CUDA_HOME}/lib64/ -O2 -D_GLIBCXX_USE_CXX11_ABI=0

# TF1.4
#g++ -std=c++11 tf_sampling.cpp tf_sampling_g.cu.o -o tf_sampling_so.so -shared -fPIC -I ${TF_DIR}/include -I ${CUDA_HOME}/include -I ${TF_DIR}/include/external/nsync/public -lcudart -L ${CUDA_HOME}/lib64/ -L${TF_DIR} -ltensorflow_framework -O2 -D_GLIBCXX_USE_CXX11_ABI=0
