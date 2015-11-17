// put this file under tools folder of caffe and make again

#include <string>
#include <vector>

#include "boost/algorithm/string.hpp"
#include "google/protobuf/text_format.h"

#include "caffe/blob.hpp"
#include "caffe/common.hpp"
#include "caffe/net.hpp"
#include "caffe/proto/caffe.pb.h"
#include "caffe/util/db.hpp"
#include "caffe/util/io.hpp"
#include "caffe/vision_layers.hpp"

using caffe::Blob;
using caffe::Caffe;
using caffe::Datum;
using caffe::Net;
using boost::shared_ptr;
using std::string;

#define Dtype float

int main(int argc, char** argv) {

  if (argc!=4){
    std::cout<<"Usage: "<<argv[0]<<" architecture.prototxt net_param.caffemodel output.marvin"<<std::endl;
    return 0;
  }

  shared_ptr<Net<Dtype> > net(new Net<Dtype>(std::string(argv[1]), caffe::TEST));
  net->CopyTrainedLayersFrom(std::string(argv[2]));  

  const std::vector<shared_ptr<caffe::Layer<Dtype> > > layers_ = net->layers();
  const std::vector<string> layer_names_ = net->layer_names();

  FILE* fmodel = fopen(argv[3],"wb");

  for (int i = 0; i <= layers_.size(); ++i) {

    if (layers_[i]->blobs().size()>0){

      uint8_t typeValue = 1;
      uint32_t typeSize = 4;
      fwrite((void*)(&typeValue), sizeof(uint8_t), 1, fmodel);
      fwrite((void*)(&typeSize), sizeof(uint32_t), 1, fmodel);

      std::string strname = layer_names_[i] + std::string(".weight");
      std::cout<<"Layer "<<i<<": "<<strname;
      std::vector<int> dim = layers_[i]->blobs()[0]->shape();
      int n = layers_[i]->blobs()[0]->count();
      const Dtype* CPUmem = layers_[i]->blobs()[0]->cpu_data();

      int lenName = strname.size();
      if (lenName>0) fwrite((void*)(&lenName), sizeof(int), 1, fmodel);
      fwrite((void*)(strname.data()), sizeof(char), lenName, fmodel);
      int nbDims = dim.size();
      fwrite((void*)(&nbDims), sizeof(int), 1, fmodel);
      if (nbDims>0) fwrite((void*)(&dim[0]), sizeof(int), nbDims, fmodel);
      if (ferror (fmodel)){ std::cout << __LINE__ <<  "disk writing failed"<<std::endl; exit(0); } 
      if (n>0){
        fwrite((void*)(CPUmem), sizeof(Dtype), n, fmodel);
        if (ferror (fmodel)){ std::cout << __LINE__ <<  "disk writing failed"<<std::endl; exit(0); } 
      }
      fflush(fmodel);
      std::cout<<" done"<<std::endl;      
    }

    if (layers_[i]->blobs().size()>1){

      uint8_t typeValue = 1;
      uint32_t typeSize = 4;
      fwrite((void*)(&typeValue), sizeof(uint8_t), 1, fmodel);
      fwrite((void*)(&typeSize), sizeof(uint32_t), 1, fmodel);

      std::string strname = layer_names_[i] + std::string(".bias");
      std::cout<<"Layer "<<i<<": "<<strname;
      std::vector<int> dim = layers_[i]->blobs()[1]->shape();
      int n = layers_[i]->blobs()[1]->count();
      const Dtype* CPUmem = layers_[i]->blobs()[1]->cpu_data();

      int lenName = strname.size();
      if (lenName>0) fwrite((void*)(&lenName), sizeof(int), 1, fmodel);
      fwrite((void*)(strname.data()), sizeof(char), lenName, fmodel);
      int nbDims = dim.size();
      fwrite((void*)(&nbDims), sizeof(int), 1, fmodel);
      if (nbDims>0) fwrite((void*)(&dim[0]), sizeof(int), nbDims, fmodel);
      if (ferror (fmodel)){ std::cout << __LINE__ <<  "disk writing failed"<<std::endl; exit(0); } 
      if (n>0){
        fwrite((void*)(CPUmem), sizeof(Dtype), n, fmodel);
        if (ferror (fmodel)){ std::cout << __LINE__ <<  "disk writing failed"<<std::endl; exit(0); } 
      }
      fflush(fmodel);
      std::cout<<" done"<<std::endl;
    }
  }

  fclose(fmodel);

  return 0;
}
