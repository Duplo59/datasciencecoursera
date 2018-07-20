## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function
#-- -----------------------------------------------------------------------
## The function gets a matrix as input and creates a cachable matrix object
## The <<- operatore is used to assign to assign a value to an object in an
## environment that is different from the current environment.

makeCacheMatrix <- function(mat = matrix()) {
	InverseMatrix <- NULL						#initialization step
 
# SetMatrix function
	setMatrix <- function(y) {
            mat <<- y
            InverseMatrix <<- NULL
    }

# GetMatrix function
	getMatrix <- function() {
	mat
	} 
	
# SetInverseMatrix function
	setInverseMatrix <- function(inverse) {
	InverseMatrix <<- inverse
	}  

# GetInverseMatrix function
	getInverseMatrix <- function() {
	InverseMatrix 
	}

# List of Objects to be referred using $ operator
	list(setMatrix = setMatrix, 
		getMatrix = getMatrix,
		setInverseMatrix = setInverseMatrix,
		getInverseMatrix = getInverseMatrix)
}

## Write a short comment describing this function
# The function takes the output of the previous function and, if not cached, 
# computes the inverse matrix

cacheSolve <- function(mat, ...) {

# Get the inverse matrix from makeCacheMatrix function
        InverseMatrix <- mat$getInverseMatrix()

# Check in order to find if the inverse matrix is already available in cache.
# In this case, a message is displayed and the matrix is returned from cache.
# If not, the inverse matrix is computed via solve function and the returned		
	if(!is.null(InverseMatrix)) {
        message("Getting inverse matrix cached data")
        return(InverseMatrix)
    }

# If Inverse Matrix is not availabile then .. 
# Retrieve the input matrix
		MatData <- mat$getMatrix()
        
# Compute inverse matrix
		InverseMatrix <- solve(MatData, ...)

# Set inverse matrix
        mat$setInverseMatrix(InverseMatrix)
		
# Return inverse matrix
        InverseMatrix
}

