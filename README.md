# Image Processing Pipeline

This repository contains an image processing pipeline using OpenCV, numpy, imutils, easyocr, and Matplotlib. The pipeline processes an image to detect and annotate number plates.

## Dockerfile

The Dockerfile sets up the environment required to run the Jupyter Notebook. It uses the latest Ubuntu image and installs the necessary Python packages.

### Steps:
1. Use the latest Ubuntu image.
2. Update the package list and install Python 3, pip, and virtual environment.
3. Create and activate a virtual environment, then install necessary Python packages (`jupyter`, `numpy`, `pandas`, `opencv-python`, `imutils`, `matplotlib`).
4. Set the working directory to `/main`.
5. Copy the contents of the current directory to `/main` in the container.
6. Set the entrypoint to run Jupyter Notebook.
main.ipynb

The Jupyter Notebook `main.ipynb` processes an image using the following steps:

1. **Image Reading and Display:**
   - Load and display an image using OpenCV and Matplotlib.

2. **Grayscale Conversion:**
   - Convert the image to grayscale.

3. **Bilateral Filtering:**
   - Apply a bilateral filter for noise reduction.

4. **Edge Detection:**
   - Perform edge detection using the Canny edge detector.

5. **Find and Sort Contours:**
   - Find contours in the edge-detected image and sort them to identify potential number plates.

6. **Segment and Crop Image:**
   - Segment the image to isolate the number plate and crop it.

7. **Text Recognition:**
   - Use easyocr to read text from the cropped image.

8. **Annotate Original Image:**
   - Annotate the original image with detected text.

## Sequence Diagram
```mermaid
sequenceDiagram
    participant User 
    participant System
    participant Matplotlib
    participant numpy
    participant imutils
    participant easyocr
    participant CV2

    User ->> System: Load Image into System

    Activate CV2
    System ->> CV2: Convert the image to Gray Scale Image using cvtColor function
    CV2 -->> System: return Gray image
    Deactivate CV2

    Activate Matplotlib
    System ->> Matplotlib: Plot the gray image
    Deactivate Matplotlib

    Activate CV2
    System ->> CV2: Apply a bilateral Filter to the grayScale Image.
    CV2 -->> System: Return the image with the filter applied back.
    Deactivate CV2

    Activate CV2
    System ->> CV2: Perform Edge detection using Canny.
    CV2 -->> System: Return the image back.
    Deactivate CV2

    Activate Matplotlib
    System ->> Matplotlib: Display the edge-detected image
    Deactivate Matplotlib

    Activate CV2
    System ->> CV2: Find contours in the edge-detected image
    CV2 -->> System: Return keypoints
    Deactivate CV2

    Activate imutils
    System ->> imutils: Extract contours from keypoints
    imutils -->> System: Return contours
    Deactivate imutils

    Activate numpy
    System ->> numpy: Sort the contours by area in descending order and keep the top 10
    numpy -->> System: Return sorted contours
    Deactivate numpy

    Note right of System: Loop through the contours and analyze if they represent a square or a number plate

    Activate CV2
    System ->> CV2: Approximate the polygon from the contour
    CV2 -->> System: Return approximated contour
    Deactivate CV2

    Note right of System: Check if a contour has 4 points to identify potential number plate

    Activate CV2
    System ->> CV2: Create a mask of the same shape as the grayscale image, filled with zeros (uint8)
    CV2 -->> System: Return mask
    Deactivate CV2

    Activate CV2
    System ->> CV2: Draw the contour on the mask
    CV2 -->> System: Return mask with drawn contour
    Deactivate CV2

    Activate CV2
    System ->> CV2: Use bitwise_and to extract the segment of the image that represents the number plate
    CV2 -->> System: Return segmented image
    Deactivate CV2

    Activate Matplotlib
    System ->> Matplotlib: Display the segmented image
    Deactivate Matplotlib

    Activate CV2
    System ->> CV2: Get coordinates for cropping the image
    CV2 -->> System: Return coordinates
    Deactivate CV2

    Activate CV2
    System ->> CV2: Crop the grayscale image using the coordinates
    CV2 -->> System: Return cropped image
    Deactivate CV2

    Activate Matplotlib
    System ->> Matplotlib: Display the cropped image
    Deactivate Matplotlib

    Activate easyocr
    System ->> easyocr: Instantiate a reader method and pass it through the language English 'en'
    easyocr -->> System: Return reader instance
    Deactivate easyocr

    Activate easyocr
    System ->> easyocr: Use the read text method on the cropped image
    easyocr -->> System: Return result
    Deactivate easyocr

    Activate CV2
    System ->> CV2: Annotate the original image with the detected text
    CV2 -->> System: Return annotated image
    Deactivate CV2

    Activate Matplotlib
    System ->> User: Display the final annotated image
    Deactivate Matplotlib
```

## Running the Project

To run the project, build and run the Docker container:
```sh
#Build the Docker image
docker build -t image-processing-pipeline.
```
```sh
#Run the Docker container
docker run -p 8888:8888 image-processing-pipeline
```
Access the Jupyter Notebook by navigating to http://localhost:8888 in your web browser.

## Requirements
  - Docker
  - Basic knowledge of Jupyter Notebooks and Python
  - Understanding of OpenCV for image processing

## Contributing
Feel free to fork this repository and submit pull requests. Contributions are welcome!

## License
This project is licensed under the MIT License.

## Note
Make sure that your repository settings on GitHub support the rendering of Mermaid diagrams. If Mermaid diagrams do not render correctly on GitHub, you may need to use an external viewer or plugin that supports Mermaid, or include a static image of the diagram instead.

