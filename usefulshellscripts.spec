Name:           usefulshellscripts
Version:        0.1.1
Release:        1%{?dist}
Summary:        Collection of useful shell scripts for Fedora

License:        MIT
URL:            https://github.com/MariosMoraitis/UsefullShellScripts
Source0:        %{url}/archive/refs/tags/v%{version}.tar.gz#/%{name}-%{version}.tar.gz

BuildArch:      noarch
BuildRequires:  make

Requires:       bash
Requires:       dnf
Recommends:     flatpak
Recommends:     fwupd

%description
A collection of small shell scripts for everyday Fedora use.

autoupdate updates DNF packages and Flatpaks, checks for firmware
updates, and can optionally shut down or reboot afterwards.

usb-formatter formats USB drives.

%prep
%autosetup -n UsefullShellScripts-%{version}

%install
make install DESTDIR=%{buildroot} PREFIX=%{_prefix}

%files
%license LICENSE
%doc README.md
%{_bindir}/autoupdate
%{_bindir}/usb-formatter

%changelog
* Thu Oct 29 2026 Marios Moraitis <you@example.com> - 0.1.1-1
- Initial package
