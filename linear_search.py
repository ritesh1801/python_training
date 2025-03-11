def linear_search(arr, match):
    
    for i in range(len(arr)):
        if arr[i] == match:
            return i  
    return -1 

arr = list(map(int, input("Enter numbers:").split()))
match = int(input("Enter the number to search: "))
result = linear_search(arr, match)

if result != -1:
    print(f"Number {match} found at index {result}")
else:
    print(f"Number {match} not found in the list")