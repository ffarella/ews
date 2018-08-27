EWS local python installation
============


1. Open **VSCode** and open a terminal.
2. Go in the scripts
2. Type:
    ```
    DEL /f %USERPROFILE%\.condarc
    DEL /f %USERPROFILE%\.conda
    "%EWS_BIN_DIR%/miniconda2/Scripts/activate"
    conda update -n base conda --yes
    conda create --name ewsbase_py36 python=3.6 --yes
    conda create --name ewsbase_py27 python=2.7 --yes
    conda create --name pgadmin4 python=3.6 --yes


    activate ewsbase_py27
    conda config --system --prepend channels conda-forge
    conda config --system --prepend channels pyviz
    conda config --system --prepend channels msys2
    conda config --system --set auto_update_conda false
    conda config --system --set show_channel_urls true    
    conda install --yes --file %EWS_INST_DIR%/ews_environnement/local_deployement/env_ewsbase_py27.txt
    pip --no-cache-dir install -r %EWS_INST_DIR%/ews_environnement/local_deployement/requirements_pip_py27.txt    
    jupyter --config-dir
    jupyter notebook --config="%JUPYTER_CONFIG_DIR%\jupyter_notebook_config.py" --generate-config
    jupyter nbextension enable --py widgetsnbextension --user
    jupyter nbextension enable codefolding/main --user
    jupyter nbextension enable collapsible_headings/main --user
    jupyter nbextension enable toc2/main --user
    jupyter nbextension enable highlighter/highlighter --user
    jupyter nbextension enable hide_input/main --user
    jupyter nbextension enable hide_header/main --user
    jupyter nbextension enable datestamper/main --user
    jupyter nbextension enable toggle_all_line_numbers/main --user
    jupyter nbextension enable autoscroll/main --user
    jupyter nbextension enable limit_output/main --user
    jupyter nbextension enable hide_header/main --user
    jupyter nbextension enable hide_input_all/main --user
    jupyter nbextension enable execute_time/ExecuteTime --user
    jupyter nbextension enable splitcell/splitcell --user
    jupyter nbextension enable zenmode/main --user
    jupyter nbextension enable spellchecker/main --user
    jupyter nbextension enable collapsible_headings/main --user
    jupyter nbextension enable varInspector/main --user
    jupyter nbextension enable move_selected_cells/main --user
    jupyter lab path
    jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build
    jupyter labextension install jupyter-leaflet --no-build
    jupyter labextension install @pyviz/jupyterlab_pyviz --no-build
    jupyter labextension install @jupyterlab/toc
    jupyter lab build
    conda clean -tipsy && npm cache clean --force && yarn cache clean --force
    deactivate


    activate ewsbase_py36   
    conda install --yes --file %EWS_INST_DIR%/ews_environnement/local_deployement/env_ewsbase_py36.txt
    pip --no-cache-dir install -r %EWS_INST_DIR%/ews_environnement/local_deployement/requirements_pip_py36.txt
    jupyter lab path
    jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build
    jupyter labextension install jupyter-leaflet --no-build
    jupyter labextension install @pyviz/jupyterlab_pyviz --no-build
    jupyter labextension install @jupyterlab/toc --no-build
    jupyter lab build
    conda clean -tipsy && npm cache clean --force && yarn cache clean --force
    deactivate

    activate  ewsbase_py27 && conda list --export > %EWS_INST_DIR%/ews_environnement/local_deployement/package_list_ewsbase_py27.txt && conda list  > %EWS_INST_DIR%/ews_environnement/local_deployement/package_list_ewsbase_py27_f.txt && deactivate
    activate  ewsbase_py36 && conda list --export > %EWS_INST_DIR%/ews_environnement/local_deployement/package_list_ewsbase_py36.txt &&  conda list > %EWS_INST_DIR%/ews_environnement/local_deployement/package_list_ewsbase_py36_f.txt && deactivate

    ```
3. To facilitate the work with Jupyter, add the following lines:
    ```    
    c.NotebookApp.iopub_data_rate_limit = 1e8
    c.NotebookApp.token = ''
    c.NotebookApp.browser = "D:/EWS/bin/GoogleChromePortable/GoogleChromePortable.exe  %s"
    ```

4. Check the installation using:
    ```
     
    node --version && npm --version
    gdalinfo --version
    rio --version
    gdalinfo --formats
    ogrinfo --formats
    cd %EWS_INST_DIR%/ews_environnement/local_deployement/ 
    python -c "import test_installation; test_installation.test()"
    
    ```