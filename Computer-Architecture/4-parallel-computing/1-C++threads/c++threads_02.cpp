//Create a group of C++11 threads from the main program

#include <iostream>
#include <sstream>
#include <thread>

static const int num_threads = 10;

//This function will be called from a thread

void call_from_thread(int tid) {
	std::stringstream s;
	s << "Launched by thread " << tid << std::endl;
    std::cout <<  s.str() ;
}

int main() {
    std::thread t[num_threads];
    int input[num_threads];

    //Launch a group of threads
    for (int i = 0; i < num_threads; ++i) {
        t[i] = std::thread(call_from_thread, i);
    }

    std::cout << "Launched from the main" << std::endl;

    //Join the threads with the main thread
    for (int i = 0; i < num_threads; ++i) {
        t[i].join();
    }

    return 0;
}