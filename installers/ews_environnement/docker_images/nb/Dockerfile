# Ubuntu 18.04 (bionic) from 2018-05-26
# https://github.com/docker-library/official-images/commit/aac6a45b9eb2bffb8102353c350d341a410fb169
FROM ubuntu:bionic-20180526@sha256:c8c275751219dadad8fa56b3ac41ca6cb22219ff117ca98fe82b42f24e1ba64e

LABEL maintainer="Fabien Farella <f.farella@ews-consulting.com>"

USER root

# Install all OS dependencies for notebook server that starts but lacks all
# features (e.g., download as all possible file formats)
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -yq dist-upgrade \
    && apt-get install -yq --no-install-recommends \
    wget \
    bzip2 \
    ca-certificates \
    sudo \
    locales \
    fonts-liberation \
    build-essential \
    emacs \
    curl \
    git \
    g++ \
    gcc \
    gfortran \
    inkscape \
    jed \
    libsm6 \
    libxext-dev \
    libxrender1 \
    lmodern \
    netcat \
    pandoc \
    python-dev \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-generic-recommended \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-xetex \
    unzip \
    nano \
    ffmpeg \
    graphviz \
    libglu1-mesa \
    fonts-dejavu \
    tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Configure environment
ENV CONDA_DIR=/opt/conda \
    SHELL=/bin/bash \
    NB_USER=ewsuser \
    NB_UID=1000 \
    NB_GID=100 \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8
ENV PATH=$CONDA_DIR/bin:$PATH \
    HOME=/home/$NB_USER

ADD fix-permissions /usr/local/bin/fix-permissions

# Create ewsuser user with UID=1000 and in the 'users' group
# and make sure these dirs are writable by the `users` group.
RUN groupadd wheel -g 11 && \
    echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su && \
    useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    mkdir -p $CONDA_DIR && \
    chown $NB_USER:$NB_GID $CONDA_DIR && \
    chmod g+w /etc/passwd && \
    fix-permissions $HOME && \
    fix-permissions $CONDA_DIR

USER $NB_UID
ENV LIBGL_ALWAYS_INDIRECT 1

# Setup work directory for backward-compatibility
RUN mkdir /home/$NB_USER/work && \
    fix-permissions /home/$NB_USER

# Install conda as ewsuser and check the md5 sum provided on the download site
ENV MINICONDA_VERSION 4.5.4
RUN cd /tmp && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda2-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    /bin/bash Miniconda2-${MINICONDA_VERSION}-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda2-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    $CONDA_DIR/bin/conda config --system --prepend channels conda-forge && \
    $CONDA_DIR/bin/conda config --system --set auto_update_conda false && \
    $CONDA_DIR/bin/conda config --system --set show_channel_urls true && \
    $CONDA_DIR/bin/conda install --quiet --yes conda="${MINICONDA_VERSION%.*}.*" && \
    $CONDA_DIR/bin/conda update --all --quiet --yes && \
    conda clean -tipsy && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER


COPY django_requirements.txt /home/$NB_USER/django_requirements.txt 
# Install Jupyter Notebook, Lab
# Generate a notebook server config
# Cleanup temporary files
# Correct permissions
# Do all this in a single RUN command to avoid duplicating all of the
# files across image layers when the permissions change
RUN conda install --quiet --yes \
    'tini=0.18.0' \
    'conda-forge::nodejs=9.11.1' \
    'conda-forge::notebook=5.6.*' \
    'conda-forge::jupyterlab=0.33.*' \
    'python==2.7.15' \
    # Pandas stack and drivers
    'conda-forge::blas=*=openblas' \
    'conda-forge::numpy=1.14.*'\
    'conda-forge::pandas=0.23.*' \ 
    'conda-forge::pandas-datareader=0.6.*' \
    'conda-forge::numexpr=2.6.*' \
    'conda-forge::sympy=1.*' \
    'conda-forge::python-snappy=0.5.*' \
    'conda-forge::blosc=1.14.*' \
    'conda-forge::fastparquet=0.1.*' \
    'conda-forge::pyarrow=0.10.*' \
    'conda-forge::xarray=0.10.*' \
    'conda-forge::pytables=3.4.*' \
    'conda-forge::scipy=1.1.*' \
    'conda-forge::statsmodels=0.9.*' \
    'conda-forge::patsy=0.5.*' \
    'conda-forge::scikit-learn=0.19.*' \
    'conda-forge::scikit-image=0.14.*' \
    'conda-forge::cython=0.28.*' \
    'conda-forge::numba=0.38.*' \
    # Plotting stack
    'conda-forge::altair=2.2.*' \
    'conda-forge::seaborn=0.8.*' \
    'conda-forge::dask=0.18.*' \
    'conda-forge::dash=0.26.*' \
    'conda-forge::plotly=2.7.*' \
    'conda-forge::brewer2mpl=1.4.*' \
    'conda-forge::folium=0.6.*' \
    'conda-forge::branca=0.3.*' \
    'conda-forge::ggplot=0.11.*' \
    'conda-forge::bqplot=0.11.*' \
    'conda-forge::vincent=0.4.*' \
    # holoviews stack
    #'pyviz::pyviz' \
    'conda-forge::bokeh=0.13.*' \
    'conda-forge::holoviews=1.10.*' \
    'conda-forge::geoviews=1.5.*' \
    'conda-forge::datashader=0.6.*' \
    'conda-forge::hvplot=0.2.*' \
    # 'conda-forge::param=1.7.*' \
    # 'conda-forge::paramnb=2.0.*' \
    # 'conda-forge::parambokeh=0.2.*' \
    # Database stack
    'conda-forge::sqlalchemy=1.2.*' \
    'conda-forge::sqlalchemy-utils=0.33.*' \
    'conda-forge::sqlite=3.24.*' \
    'conda-forge::psycopg2=2.7.*' \
    'conda-forge::pymongo=3.7.*' \
    # parallel stack    
    'conda-forge::cloudpickle=0.4.*' \
    'conda-forge::distributed=1.22.1' \
    'conda-forge::joblib=0.12.*' \
    'conda-forge::futures=3.2.*' \
    # other stuff
    'conda-forge::cycler=0*' \
    'conda-forge::yaml=0.1.7' \
    'conda-forge::requests=2.19.1' \
    'anaconda::pydot=1.2.*' \
    'anaconda::pydot-ng=1.0.0.*' \
    # 'conda-forge::graphviz=2.38.*' \
    'anaconda::snakeviz=0.4.*' \
    'anaconda::pycurl=7.*' \
    'conda-forge::pyephem=3.7.*' \
    'conda-forge::pillow' \
    # Excel stack
    'conda-forge::xlrd=1.1.*' \
    'conda-forge::xlsxwriter=1.0.*' \
    'conda-forge::xlwt=1.3.*' \
    # GIS stack
    'conda-forge::mercantile=1.0.*' \
    'conda-forge::gdal=2.*' \
    'conda-forge::libgdal=2.*' \ 
    'conda-forge::shapely=1.6.*' \
    'conda-forge::fiona=1.7.*' \
    'conda-forge::rasterio=1.0.*' \
    'conda-forge::geopandas=0.4.*' \
    'conda-forge::parse=1.8.*' \
    'conda-forge::h5py=2.8.*' \
    # 'conda-forge::proj4=4.9.*' \
    # 'conda-forge::hdf4=4.2.*' \
    # 'conda-forge::hdf5=1.10.*' \
    # 'conda-forge::libnetcdf=4.6.*' \
    # 'conda-forge::libpng=1.6.*' \
    # 'conda-forge::libspatialite=4.3.*' \
    'conda-forge::libtiff=4.0.*' \
    'conda-forge::netcdf4' \
    'conda-forge::owslib=0.16.*' \
    'conda-forge::pyepsg=0.3.*' \
    'conda-forge::pykml=0.1.*' \
    'conda-forge::simplekml=1.3.*' \
    'conda-forge::pyshp=1.2.*' \
    'conda-forge::utm=0.4.*' \
    'conda-forge::cartopy=0.16.*' \
    'conda-forge::geojson=2.0.*' \
    'conda-forge::geojsonio=0.0.*' \
    'conda-forge::osmnx=0.8.*' \
    # IPython/Jupyter stack
    'conda-forge::ipywidgets=7.4.*' \
    'conda-forge::ipyleaflet=0.9.*' \
    'conda-forge::ipyparallel=6.2.*' \
    'conda-forge::jupyter_contrib_nbextensions=0.5.*' \
    'conda-forge::jupyter_nbextensions_configurator=0.4.*' \
    # Flask stack
    'conda-forge::apispec=0.38.0' \
    'conda-forge::werkzeug=0.14.*' \
    'conda-forge::marshmallow=3.0.*' \
    'conda-forge::marshmallow-sqlalchemy=0.14.*' \
    'conda-forge::itsdangerous=0.24' \
    'conda-forge::jinja2=2.*' \
    'conda-forge::flask=1.0.2' \
    'conda-forge::flask-admin=1.5.*' \
    'conda-forge::flask-apispec=0.7.*' \
    'conda-forge::flask-babelex=0.9.*' \
    'conda-forge::flask-bcrypt=0.7.*' \
    'conda-forge::flask-cache=0.13.*' \
    'conda-forge::flask-cors=3.0.*' \
    'conda-forge::flask-httpauth=3.2.*' \
    'conda-forge::pyjwt=1.6.*' \
    'conda-forge::flask-jwt-extended=3.12.*' \
    'conda-forge::flask-login=0.4.*' \
    'conda-forge::flask-mail=0.9.*' \
    'conda-forge::flask-marshmallow=0.9.*' \
    'conda-forge::flask-migrate=2.2.*' \
    'conda-forge::flask-oauthlib=0.9.*' \
    'conda-forge::flask-principal=0.4.*' \
    'conda-forge::flask-restplus=0.11.*' \
    'conda-forge::flask-restless=1.0.*' \
    'conda-forge::flask-script=2.0.*' \
    'conda-forge::flask-security=3.0.*' \
    'conda-forge::flask-socketio=3.0.*' \
    'conda-forge::flask-sqlalchemy=2.3.*' \
    'conda-forge::flask-uploads=0.2.*' \
    'conda-forge::flask-user=1.0.*' \
    'conda-forge::flask-wtf=0.14.*' \
    # Machine learning stack
    'conda-forge::keras=2.2*' \
    'conda-forge::tensorflow<1.6' \
    # 'pytorch::pytorch=0.4*' \ # interseting only with GPU (comes with MKL)
    'conda-forge::xgboost=0.72*' \
    'anaconda::py-xgboost=0.72*' \
    # Linting
    'conda-forge::flake8' \ 
    'conda-forge::pep8' \
    'conda-forge::pylint' \
    'conda-forge::pydocstyle' \
    # Other stuff
    'intake::intake' \
    'intake::intake-parquet' \
    'intake::intake-xarray' \
    'intake::intake-mongo' \ 
    # Deployement
    'conda-forge::celery' \
    'conda-forge::gunicorn' \
    'conda-forge::uwsgi' \
    'conda-forge::gevent' \
    && \    
    conda list tini | grep tini | tr -s ' ' | cut -d ' ' -f 1,2 >> $CONDA_DIR/conda-meta/pinned && \
    jupyter notebook --generate-config && \
    jupyter nbextension enable --py widgetsnbextension --sys-prefix && \
    jupyter nbextension enable codefolding/main --sys-prefix && \
    jupyter nbextension enable collapsible_headings/main --sys-prefix && \
    jupyter nbextension enable toc2/main --sys-prefix && \
    jupyter nbextension enable highlighter/highlighter --sys-prefix && \
    jupyter nbextension enable hide_input/main --sys-prefix && \
    jupyter nbextension enable hide_header/main --sys-prefix && \
    jupyter nbextension enable datestamper/main --sys-prefix && \
    jupyter nbextension enable toggle_all_line_numbers/main --sys-prefix && \
    jupyter nbextension enable autoscroll/main --sys-prefix && \
    jupyter nbextension enable limit_output/main --sys-prefix && \
    jupyter nbextension enable hide_header/main --sys-prefix && \
    jupyter nbextension enable hide_input_all/main --sys-prefix && \
    jupyter nbextension enable execute_time/ExecuteTime --sys-prefix && \
    jupyter nbextension enable splitcell/splitcell --sys-prefix && \
    jupyter nbextension enable zenmode/main --sys-prefix && \
    jupyter nbextension enable spellchecker/main --sys-prefix && \
    jupyter nbextension enable collapsible_headings/main --sys-prefix && \
    jupyter nbextension enable varInspector/main --sys-prefix && \
    jupyter nbextension enable move_selected_cells/main --sys-prefix && \
    jupyter labextension install @jupyterlab/hub-extension@^0.10.0 --no-build && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build && \
    jupyter labextension install jupyter-leaflet --no-build && \
    jupyter labextension install @pyviz/jupyterlab_pyviz --no-build && \
    jupyter labextension install @jupyterlab/toc --no-build && \
    jupyter lab build && \
    conda remove --quiet --yes --force qt pyqt && \
    conda install  --quiet mayavi vtk=6.3* --yes && \
    conda remove --quiet --yes --force qt pyqt && \ 
    conda clean -tipsy && \
    npm cache clean --force && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER && \ 
    pip --no-cache-dir install pyecharts echarts-countries-pypkg cesiumpy && \ 
    pip --no-cache-dir install  -r /home/$NB_USER/django_requirements.txt && \ 
    jupyter nbextension enable echarts/main --sys-prefix && \
    jupyter nbextension enable echarts-countries-js/index --sys-prefix


ENV PYTHONPATH=/home/$NB_USER/python_libs
ENV MKL_THREADING_LAYER=GNU

USER root

# EWS Python libraries
RUN mkdir -p /home/$NB_USER/python_libs/ews_utils
COPY ./ews_utils /home/$NB_USER/python_libs/ews_utils
RUN fix-permissions /home/$NB_USER

# Check the installation

RUN conda install  --quiet --yes mkl-service && conda remove --yes tensorflow keras && \
    pip install --no-cache-dir tensorflow==1.5.0 keras==2.2.0 && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER && \ 
    python -c "from ews_utils import test_installation; test_installation.test()" && \
    MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions /home/$NB_USER && \
    conda list --show-channel-urls > /home/$NB_USER/package-list.txt && \
    conda list --export > /home/$NB_USER/requirements.txt


EXPOSE 8888
WORKDIR $HOME

# Configure container startup
ENTRYPOINT ["tini", "-g", "--"]
CMD ["start-notebook.sh"]

# Add local files as late as possible to avoid cache busting
COPY start.sh /usr/local/bin/
COPY start-notebook.sh /usr/local/bin/
COPY start-singleuser.sh /usr/local/bin/
COPY jupyter_notebook_config.py /etc/jupyter/
RUN fix-permissions /usr/local/bin
RUN fix-permissions /etc/jupyter/

# Switch back to ewsuser to avoid accidental container runs as root
USER $NB_UID
