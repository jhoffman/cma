Continuous Manifold-based Adaptation (cma)
===

Paper
-----


Dependencies
----------
First, move into the external folder. The following instructions show you how to download and compile relevant packages.
<pre>
  cd external
</pre>
* Geodesic flow kernel (GFK)
  * unsupervised adaptation method needed to run demo.
  * Download the package.
  <pre>
    ./get_GFK.sh
  </pre>
* Vlfeat
  * Choose either to checkout the repo 
  <pre>
    ./checkout_vlfeat.sh
  </pre>
  OR download a static copy.
  <pre>
    ./get_vlfeat.sh
  </pre>
* IVT
  * Online subspace optimization algorithm.
  * Download IVT.
  <pre>
    ./get_ivt.sh
  </pre>
* Liblinear
  * Download liblinear.
  <pre>
    ./get_liblinear.sh
  </pre>
  * Compile liblinear using the following commands. Will likely need to change the MATLABDIR at the top of liblinear/matlab/Makefile to be the directory of your matlab. On Mac this is often: /Applications/MATLAB_R2013a.app
  <pre>
    cd liblinear
    make
    cd matlab
    make
  </pre>


Run the demo
------------
Once the dependencies are downloaded and installed you can run a simple demo on the caltran gist features using the following command.
<pre>
results = demo_caltran('gist');
</pre>
