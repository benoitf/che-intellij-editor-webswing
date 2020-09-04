# che-intellij-editor-webswing
POC for Intellij community inside Eclipse Che with webswing

To test:

https://che.openshift.io/f/?url=https://gist.githubusercontent.com/benoitf/3f165378614f9c0d1716747aa52a9626/raw/che-intellij-webswing-devfile.yaml


webswing inside iframe is not working properly with the webswing security (user null issue)
So the index.html redirect from within the iframe to a full window to make it open correctly.
