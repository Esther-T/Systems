#define THREADS_PER_BLK 128
__global__ void Testcode(int N, float* A, float* B) {
int i = blockIdx.x * blockDim.x + threadIdx.x; // thread local variable
if (i<(N-1)&& i>0) B[i] = A[i]+A[i-1]+A[i+1];
if (i==0) B[i] = A[i]+A[i+1];
if (i==(N-1)) B[i]= A[i] + A[i-1];
}
__host__
int N = 1024
float *input, *output;
//instructions, using cudamalloc(&input, sizeof(float)*N) and
cudamalloc(&output, sizeof(float)*N) to allocate arrays A,B in device and
memcopy to load/copy data – ignore for this example
Testcode<<<N/THREADS_PER_BLOCK, THREADS_PER_BLOCK>>>(N,input,output);


/*
Equivalent for C sequential code

void TestCode(int N, float* A, float*B)
{
    for(int i = 0; i < N; i ++)
    {
        if (i == 0)
        {
            B[i] = A[i] + A[i + 1];
        }
        else if (i == N - 1)
        {
            B[i] = A[i-1] + A[i];
        }
        else
        {
            B[i] = A[i-1] + A[i] + A[i + 1];
        }
        
    }
}

int main()
{
    TestCode(1024, A, B);
}


*/