FROM ubuntu:latest

# Update and install Python, pip, and venv
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv

# Create and activate a virtual environment, then install Python packages
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --upgrade pip
RUN pip install jupyter numpy pandas opencv-python imutils matplotlib

# Set the working directory
WORKDIR /main

# Copy the contents of the current directory to /main in the container
COPY . /main

# Set the entrypoint to run Jupyter Notebook
ENTRYPOINT ["jupyter", "notebook", "--ip=*", "--allow-root"]
