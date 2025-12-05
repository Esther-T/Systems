/*
This is a parallel program using Merge Sort algorithm where 
separate threads are used to sort each subarrays

Input: array A[1...N]
Output: B[1..N] such that B[i] < B[j] for any i<j

Time complexity:
	Assume T(n) represents the parallel execution time
	Since the array is divided into two everytime, we can represent that work as T(n/2)
	For merging in parallel, only max(Tleft, Tright) matters, not the sum so T(n) can be represented as:
	T(n) = max(T(n/2), T(n/2) + O(n)) = T(n/2) + O(n)
	Using the master method the big O complexity can be denoted as O(n)

Code efficiency:
	For sequential time, merge sort takes O(nlogn)
	For parallel time (see above), merge sort takes O(n)
	So efficiency = (Sequential merge sort)/(Number of Processors * parallel merge sort)
						   =  nlogn/(n*n) = O(logn/n)
	The efficiency will decrease if the number of processes increases.

Speedup:
	Speedup = (Sequential merge sort time)/(Parallel merge sort time)
            = nlogn/n = O(logn)

*/


typedef struct
{
    int *A;
    int n;
} thread_arg;


void merge(int *A, int n, int mid)
{
    int *temp = malloc(n * sizeof(int));
    int i = 0;
    int j = mid;
    int k = 0;
    
    while(i < mid && j < n)
    {
        if (A[i] < A[j])
        {
            temp[k++] = A[i++];
        }
        else
        {
            temp[k++] = A[j++];
        }
    }
    
    while(i < mid)
    {
        temp[k++] = A[i++];
    }
    
    while(j < n)
    {
        temp[k++] = A[j++];
    }
    
    for(i = 0; i < n; i++)
    {
        A[i] = temp[i];
    }
    
    free(temp);
}

void mergeSort(int L[], int nL, int R[], int nR)
{
    if (n <= 1)
    {
        return;
    }
    
    int mid = n / 2;
    
    pthread_create(&left_thread, NULL, mergeSort_thread, &left_arg);
    pthread_create(&right_thread, NULL, mergeSort_thread, &right_arg);
    
    pthread_join(left_thread, NULL);
    pthread_join(right_thread, NULL);
    
    merge(A, n, mid);
}

void *mergeSort_thread(void *arg)
{
    thread_arg *t = (thread_arg*)arg;
    mergeSort(t-> A, t-> n);
    return NULL;
}



