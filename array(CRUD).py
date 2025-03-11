class MyArray:

  def __init__(self,size):
        self.size = size
        self.data = [None] * size
   
  def setvalues(self, index, value):
        if 0 <= index < self.size:
            self.data[index] = value
        else:
            print("Index out of range")
     
  def getvalues(self, index):
        if 0 <= index < self.size:
            return self.data[index]
        else:
            print("Index out of range")
            return None
   
  def display(self):
        print(self.data)

  def search(self, value):
        if value in self.data:
            print(f"Value {value} found at index {self.data.index(value)}")
        else:
            print("Value not found")

  def delete(self, index):
        if 0 <= index < self.size:
            self.data[index] = None
            print(f"Value at index {index} has been deleted.")
        else:
            print("Index out of range")


        
# Test CRUD Operations

arr = MyArray(5)

# Create/Update operations
arr.setvalues(0, 10)  
arr.setvalues(1, 20)  
arr.setvalues(2, 30)  
arr.setvalues(3, 40)  
arr.setvalues(4, 50)  

arr.display()  # Display the array

# Read operation
print("Value at index 2:", arr.getvalues(2))  # Should print 30

# Delete operation
arr.delete(2)  # Delete value at index 2
arr.display()  # Display the array again

arr.display()