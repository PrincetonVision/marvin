// Please choose a data type to compile
#define DATATYPE 0
#include "../../marvin.hpp"
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <fstream>

int main(int argc, char **argv){
    if (argc != 5){
        std::cout<<"Usage:"<<std::endl;
        std::cout<<argv[0]<<" network.json model1.marvin[,model2.marvin,...] categories.txt webcamID"<<std::endl;
        return 0;
    }

    // initialize the network
    marvin::Net net(argv[1]);
    net.Malloc(marvin::Testing);
    std::vector<std::string> models = marvin::getStringVector(argv[2]);
    for (int m=0;m<models.size();++m)   net.loadWeights(models[m]);
    // where the data is
    marvin::Response* rData = net.responses[0];
    marvin::Response* rResult = net.responses[net.responses.size()-1];

    // image net list
    std::vector<std::string> objectCategories;
    objectCategories.resize(1000);
    std::ifstream fclass(argv[3]);
    for(int i=0;i<1000;++i){
        std::getline(fclass,objectCategories[i]);
    }
    fclass.close();


    // initialize video data feed from webcam

    cv::VideoCapture capture; //try to open string, this will attempt to open it as a video file or image sequence
    capture.open(atoi(argv[4]));

    int width_webcam = 640;
    int height_webcam = 480;

    capture.set(CV_CAP_PROP_FRAME_WIDTH,width_webcam);
    capture.set(CV_CAP_PROP_FRAME_HEIGHT,height_webcam);    
    if (!capture.isOpened()) {
        std::cerr << "Failed to open the video device, video file or image sequence!\n" << std::endl;
        return 1;
    }


    marvin::PlaceHolderDataLayer* pDataLayer = (marvin::PlaceHolderDataLayer*)net.layers[0];

    int height_network = pDataLayer->dim[2];
    int width_network = pDataLayer->dim[3];
    int numel_network = width_network*height_network*3;

    //uint8_t* imageGPU_OCV;  marvin::checkCUDA(__LINE__, cudaMalloc(&imageGPU_OCV, width_network*height_network*3));

    uint8_t* image_resize_memCPU;
	marvin::checkCUDA(__LINE__, cudaHostAlloc( (void**)&image_resize_memCPU, width_network*height_network*3*sizeof(uint8_t), cudaHostAllocWriteCombined | cudaHostAllocMapped ));

	uint8_t* image_resize_memGPU;	cudaHostGetDevicePointer( &image_resize_memGPU, image_resize_memCPU, 0 );

    cv::Mat image_original;
    cv::Mat image_resize(height_network,width_network,CV_8UC3,image_resize_memCPU);

    uint8_t* imageGPU;      marvin::checkCUDA(__LINE__, cudaMalloc(&imageGPU, width_network*height_network*3));


    // allocate CPU for the host
    StorageT* rResult_CPU; 
	marvin::checkCUDA(__LINE__, cudaHostAlloc( (void**)&rResult_CPU, rResult->numBytes(), cudaHostAllocWriteCombined | cudaHostAllocMapped ));
    marvin::Tensor<StorageT>* cpuResult = new marvin::Tensor<StorageT>(rResult->dim, rResult_CPU);

    // replace the original GPU memory
    marvin::checkCUDA(__LINE__, cudaFree(rResult->dataGPU));
	cudaHostGetDevicePointer( &(rResult->dataGPU), rResult_CPU, 0 );

    std::cout<<"====================================================================================================================================="<<std::endl;

    // while it is running
    while (true){
        // read image data, e.g. using OpenCV to get an image from webcam
        marvin::tic();
        capture >> image_original;
        std::cout<<"capture image: ";
        marvin::toc();
        if (image_original.empty()) break;

        // resize image for the network
        marvin::tic();
        cv::resize(image_original, image_resize, cv::Size(height_network,width_network));
        std::cout<<"resize image: ";
        marvin::toc();

        // copy the image from CPU to GPU
        //cudaMemcpy(imageGPU_OCV, image_resize.data, height_network*width_network*3*sizeof(uint8_t), cudaMemcpyHostToDevice);

        // convert the color image from OpenCV format (BGR with channel first) to Marvin format (CHW with RGB)
        marvin::tic();
        marvin::OpenCV_BGR_image_to_Marvin(3, height_network, width_network, image_resize_memGPU, imageGPU);
        std::cout<<"OpenCV_BGR_image_to_Marvin: ";
        marvin::toc();

        // convert image from uint8_t to StorageT on GPU
        marvin::tic();
        marvin::Kernel_convert_to_StorageT_subtract<<<marvin::CUDA_GET_BLOCKS(numel_network), CUDA_NUM_THREADS >>>(marvin::CUDA_GET_LOOPS(numel_network), numel_network, numel_network, imageGPU, pDataLayer->meanGPU, rData->dataGPU);
        std::cout<<"Kernel_convert_to_StorageT_subtract: ";
        marvin::toc();

        // test the network
        marvin::tic();
        net.forward();
        std::cout<<"net.forward(): ";
        marvin::toc();

        // read the result from GPU to CPU
        //marvin::tic();
        //cpuResult->readGPU(rResult->dataGPU);
        //std::cout<<"cpuResult->readGPU: ";
        //marvin::toc();

        // visualize the result or use the result
        imshow("Marvin webcam demo", image_resize);
        int iMax = 0;
        ComputeT vMax = 0;
        for(int i=0;i<1000;i++){
            ComputeT v = CPUStorage2ComputeT(cpuResult->CPUmem[i]);
            if (v>vMax){
                vMax = v;
                iMax = i;
            }
        }
        std::cout<<objectCategories[iMax]<<std::endl;
        //std::vector<int> display_dim = {10};
        //cpuResult->print(display_dim);

        // any keyboard input
        char key = (char)cv::waitKey(30);
        if (key=='q' || key=='Q' || key==27) break;
    }

    marvin::checkCUDA(__LINE__, cudaFree(image_resize_memGPU));
    free(image_resize_memCPU);
    marvin::checkCUDA(__LINE__, cudaFree(imageGPU));

    delete cpuResult;

    return 0;
}

