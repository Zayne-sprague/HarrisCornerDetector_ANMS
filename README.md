# HarrisCornerDetector_ANMS
An implementation of the Harris Corner Detector with Adaptive Non-Maximal Suppresion

![Notre-Dame Gif](https://github.com/Zayne-sprague/HarrisCornerDetector_ANMS/blob/master/readme_images/HarrisCornerDetector-with-ANMS.gif)

# Download & Install

`git clone https://github.com/Zayne-sprague/HarrisCornerDetector_ANMS.git`

Open the folder that was downloaded from git in matlab

Open main.m and run!

# About

### Really meant for Academic/Learning only

This is not an optimized algorithm by any means.  I did this project to learn about the algorithm as well as implement it in a way that might help others
answer some questions about the algorithm they had.  It's very fun to implement and exciting to watch work! Though I would not use this in any professional
setting.

### What is a Harris Corner Detector?

#### Intro

A Harris Corner Detector is a way to evalute an image and find interest points that are easily traced and tracked across multiple images.  
The main idea is that we want to find points on a picture that, if we rotated/scaled/moved the image, we could still easily recognize that point.

The intuition here is that corners are easier than other types of points in an image to easily find and reference when the image is transformed.

#### Whats a corner in a Harris "Corner" Detector

In this algorithm a corner is a pixel that has a large change in pixel intesities in either direction X or Y.  

In order to find pixel intesities we use a filter on the image to find derivatives (or gradients) of the image.  We find the X and Y derivatives and
then create a <a href="https://en.wikipedia.org/wiki/Hessian_matrix#:~:text=In%20mathematics%2C%20the%20Hessian%20matrix,a%20function%20of%20many%20variables.">Hessian Matrix</a>
of the gradients.

The Hessian at any given Pixel p will allow us to find some interesting properties about the eigenvalues of that pixels intensity.  (How much the intensity has
to change in one step in either direction).  When these eigenvalues are similar and large this indicates a corner (hence a large step or change in intensity in 
any given direction).

##### I DIDN'T MAKE THIS IMAGE find source <a href="https://sbme-tutorials.github.io/2018/cv/notes/6_week6.html">here</a> along with good descriptions on more corner detection stuff!

![Eigenvalue description](https://sbme-tutorials.github.io/2018/cv/images/eig2.png)

This image gives a better intuition into how we could read the eigenvalues for the hessian at any given pixel.  A Corner in a Harris Corner Detector is when
BOTH eigenvalues are large.



# ANMS

Adaptive Non-Maximal Suppression is something that I had a hard time finding online.  My implementation in this project is not optimal by far, but it gets the 
job done.  

ANMS is a way to pick points from a matrix that have the local max in some window or neighbourhood and then you only pick the maximums of those local points.  
What you end up with is usually an evenly distributed matrix of points that are the local max in the neighbourhood of pixels you took them from.  This
allows us to reduce the noise the intensity functions we use to find corners create.  

I separated how I did ANMS into a separate file so those interested in that specific algorithm they can check there.  

# TODO

- ANMS is not optimized at all, I don't plan on coming back and optimizing it any time soon, so if anyone is interested in purposing a more optimized version totally go for it and let me know! 

# Contributions

I am totally open to anyone wanting to improve or otherwise change this project.  Let me know if you want to be a collaborator or otherwise wish to contribute :) 

# Contact

name: Zayne Sprague

email: zaynettft@gmail.com

# Interesting Links 

- <a href="http://szeliski.org/Book/">The book my implemenation follows</a>
- <a href="https://en.wikipedia.org/wiki/Harris_Corner_Detector">Harris Corner Detector Wikipedia</a>
- <a href="http://www.bmva.org/bmvc/1988/avc-88-023.pdf">Original Paper on Harris Corner Detector, "A Combined Corner And Edge Detector" Chris Harris & Mike Stephens 1988</a>
