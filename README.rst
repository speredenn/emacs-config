============================
speredenn's GNU Emacs config
============================

My GNU Emacs config files.

Dependencies
============

.. code-block:: bash

   apt-get install autoconf zsh mercurial git bzr subversion

Maybe those python dependencies are not all needed. I'll have to
check...

.. code-block:: bash
                
   apt-get install python-rope pymacs python-ropemacs ipython
   apt-get install pylint

For mu4e:

.. code-block:: bash
                
   apt-get install libtool automake pkg-config libglib2.0-dev
   apt-get install libgmime-2.6-dev libxapian-dev
   apt-get install guile-2.0-dev html2text xdg-utils

Check that your locales include at least en_US.UTF-8

.. code-block:: bash

   nano /etc/locale.gen
   locale-gen

License
=======

Copyright (c) 2007-2013 Jean-Baptiste Carré (speredenn).

All software and files are licensed under the GNU General Public
License, either version 3 of the License, or (at your option) any
later version. You can find a copy of this license in <COPYING>.
