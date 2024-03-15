https://www.python.org/downloads/source/
https://devguide.python.org/getting-started/setup-building/index.html#install-dependencies
https://askubuntu.com/questions/682869/how-do-i-install-a-different-python-version-using-apt-get
https://www.youtube.com/watch?v=jpdFwfGFlq8


/etc/apt/sources.list
append the following line: deb-src http://archive.ubuntu.com/ubuntu/ jammy main
uncomment all lines starting with: # deb-src


apt update
apt build-dep python3
apt install pkg-config
apt install libffi-dev


apt install build-essential gdb lcov pkg-config libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev lzma lzma-dev tk-dev uuid-dev zlib1g-dev






On Unix, Linux, BSD, macOS, and Cygwin::

    ./configure
    make
    sudo make install

This will install Python as ``python3``.

You can pass many options to the configure script; run ``./configure --help``
to find out more.  On macOS case-insensitive file systems and on Cygwin,
the executable is called ``python.exe``; elsewhere it's just ``python``.

Building a complete Python installation requires the use of various
additional third-party libraries, depending on your build platform and
configure options.  Not all standard library modules are buildable or
useable on all platforms.  Refer to the
`Install dependencies <https://devguide.python.org/setup/#install-dependencies>`_
section of the `Developer Guide`_ for current detailed information on
dependencies for various Linux distributions and macOS.



ln -s /opt/Python-3.11.0/python /usr/bin/python






https://docs.ansible.com/ansible/latest/reference_appendices/interpreter_discovery.html
https://docs.ansible.com/ansible/latest/reference_appendices/config.html#interpreter-python

ansible_python_interpreter=/usr/local/bin/python3


ln -s /usr/local/bin/python3 /usr/bin/python3


















ln -sf /usr/local/bin/python3 python3
ln -sf /usr/local/bin/python3-config python3-config



ansible localhost -m ping -e 'ansible_python_interpreter=/usr/local/bin/python3'
ansible localhost -m setup -e 'ansible_python_interpreter=/usr/local/bin/python3' | grep ansible_python_version





    - name: Setup
      setup:
        gather_subset: python_version
      register: setup_result

    - name: Debug
      debug:
        var: setup_result.ansible_facts.ansible_python_version







root@f20597d49361:/usr/bin# ll|grep python
lrwxrwxrwx 1 root root         24 Nov 20 16:14 pdb3.10 -> ../lib/python3.10/pdb.py*
lrwxrwxrwx 1 root root         31 Aug 18  2022 py3versions -> ../share/python3/py3versions.py*
-rwxr-xr-x 1 root root        953 May  1  2021 pybabel-python3*
lrwxrwxrwx 1 root root         25 Mar  6 12:27 python -> /opt/Python-3.11.0/python*
lrwxrwxrwx 1 root root         10 Aug 18  2022 python3 -> python3.10*
lrwxrwxrwx 1 root root         17 Aug 18  2022 python3-config -> python3.10-config*
-rwxr-xr-x 1 root root    5904904 Nov 20 16:14 python3.10*
lrwxrwxrwx 1 root root         34 Nov 20 16:14 python3.10-config -> x86_64-linux-gnu-python3.10-config*
lrwxrwxrwx 1 root root         45 Dec 19  2021 sphinx-apidoc -> ../share/sphinx/scripts/python3/sphinx-apidoc*
lrwxrwxrwx 1 root root         46 Dec 19  2021 sphinx-autogen -> ../share/sphinx/scripts/python3/sphinx-autogen*
lrwxrwxrwx 1 root root         44 Dec 19  2021 sphinx-build -> ../share/sphinx/scripts/python3/sphinx-build*
lrwxrwxrwx 1 root root         49 Dec 19  2021 sphinx-quickstart -> ../share/sphinx/scripts/python3/sphinx-quickstart*
lrwxrwxrwx 1 root root         34 Aug 18  2022 x86_64-linux-gnu-python3-config -> x86_64-linux-gnu-python3.10-config*
-rwxr-xr-x 1 root root       3123 Nov 20 16:14 x86_64-linux-gnu-python3.10-config*





#----------------------------------------
# Install python 3.11.0 on RedHat ubi 8.9
#----------------------------------------
https://www.python.org/downloads/source/
https://snapcraft.io/install/my-hello-world-app/rhel
https://docs.posit.co/resources/install-python-source/
https://stackoverflow.com/questions/19292957/how-can-i-troubleshoot-python-could-not-find-platform-independent-libraries-pr
https://stackoverflow.com/questions/1439950/whats-the-opposite-of-make-install-i-e-how-do-you-uninstall-a-library-in-li



yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms
yum repolist
yum update

yum install -y yum-utils
yum-builddep python3
yum groupinstall "Development Tools"  # First register with Subscription Manager and attach a Pool



yum install -y make
# yum install -y gcc
yum install -y libffi-devel
# yum install -y zlib-devel

./configure --prefix=/usr
make
make install


export PYTHONHOME=/usr
export LD_LIBRARY_PATH=/usr/lib64



# Clean build
https://stackoverflow.com/questions/1439950/whats-the-opposite-of-make-install-i-e-how-do-you-uninstall-a-library-in-li
make clean


/usr/bin/python3.11


[root@f03aa9b870ee bin]# pwd
/usr/bin
[root@f03aa9b870ee bin]# ll|grep python
lrwxrwxrwx 1 root root   25 Mar  7 16:24 python3 -> /etc/alternatives/python3
lrwxrwxrwx 1 root root   17 Mar  7 16:15 python3-config -> python3.11-config
-rwxr-xr-x 1 root root 7.6K Oct 25 18:23 python3.11
-rwxr-xr-x 1 root root 3.0K Mar  7 16:15 python3.11-config
lrwxrwxrwx 1 root root   24 Feb 13 03:16 unversioned-python -> /etc/alternatives/python










Hi Paul,

Execute the following steps in exactly the given order. :)

Un-register the system :

sudo subscription-manager remove --all
sudo subscription-manager unregister
sudo subscription-manager clean

Re-register the system :

sudo subscription-manager register
sudo subscription-manager refresh

Search for the Pool ID :

sudo subscription-manager list --available

Attach to subscription :

sudo subscription-manager attach --pool=<Pool-ID>

Clean YUM and cache :

sudo yum clean all
sudo rm -r /var/cache/yum

Update the resources :

sudo yum upgrade












#-------------------------------------------------------
# Install python from scratch working solution finally!!
#-------------------------------------------------------

https://docs.posit.co/resources/install-python-source
https://realpython.com/installing-python/#how-to-build-python-from-source-code

# Not required to set up the epel repo, below packages come from the default repos
# yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
# yum update
yum install -y wget yum-utils make gcc openssl-devel bzip2-devel libffi-devel zlib-devel

wget https://www.python.org/ftp/python/3.11.0/Python-3.11.0.tgz


export PYTHON_VERSION=3.11.0

./configure \
--prefix=/opt/python/${PYTHON_VERSION} \
--enable-shared \
--enable-optimizations \
--enable-ipv6 \
--with-ensurepip=install \
LDFLAGS=-Wl,-rpath=/opt/python/${PYTHON_VERSION}/lib,--disable-new-dtags

make
make -j 8
make -j $(nproc)

make install
make altinstall  # You’ll use the altinstall target here to avoid overwriting the system Python. Since you’re installing into /usr/bin

make clean



# ---------------------------------
# Setting up a virtual environment
# ---------------------------------
https://www.freecodecamp.org/news/how-to-setup-virtual-environments-in-python/
https://saturncloud.io/blog/how-to-use-different-python-versions-with-virtualenv/
https://stackoverflow.com/questions/21099057/control-the-pip-version-in-virtualenv

pip3 install virtualenv
mkdir /opt/virtualenv
cd /opt/virtualenv
virtualenv -p /opt/python/3.12.2/bin/python3.12 ansible-9.3.0
source /opt/virtualenv/ansible-9.3.0/bin/activate
deactivate


# List installed pip3 packages
pip3 list
pip3 index versions ansible
pip3 install ansible==9.3.0






# Install termcolor
pip3 install termcolor

# Snippet
from termcolor import colored, cprint

print(colored("Hello World", "green"))
cprint("Hello World", "magenta")

