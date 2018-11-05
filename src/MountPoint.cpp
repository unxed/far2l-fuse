#include <string>
#include <utils.h> // far2l/utils
#include "MountPoint.h"

MountPoint::MountPoint(const MountPoint& other)
{
    m_proto = other.m_proto;
    m_url = other.m_url;
    m_user = other.m_user;
    m_password = other.m_password;
    m_mountPointPath = other.m_mountPointPath;
    m_shareName = other.m_shareName;
    m_storageId = other.m_storageId;
    m_askPassword = other.m_askPassword;
}

MountPoint& MountPoint::operator=(const MountPoint& other)
{
    m_proto = other.m_proto;
    m_url = other.m_url;
    m_user = other.m_user;
    m_password = other.m_password;
    m_mountPointPath = other.m_mountPointPath;
    m_shareName = other.m_shareName;
    m_storageId = other.m_storageId;
    m_askPassword = other.m_askPassword;
    return *this;
}

MountPoint::MountPoint():
    m_proto(EProtocol::Unknown),
    m_askPassword(false)
{
}

MountPoint::EProtocol MountPoint::SchemeToProto(const std::string& scheme)
{
    MountPoint::EProtocol ret = EProtocol::Unknown;
    if (scheme == "sftp") ret = EProtocol::Sftp;
    else if (scheme == "smb") ret = EProtocol::Samba;
    // todo: webdav
    return ret;
}

bool MountPoint::mount()
{
    std::string url(StrWide2MB(m_url));
    std::string userName(StrWide2MB(m_user));
    std::string password(StrWide2MB(m_password));

    // пароль спрашивают перед монтированием, зачищаем его
    if (m_askPassword) m_password.clear();
    if (isMounted()) return true;
    if (url.empty()) return false;

    // todo: to be implemented
    return true;
}

bool MountPoint::unmount()
{
    if (!isMounted()) return true;

    std::string url(StrWide2MB(this->m_url));
    if (url.empty()) return false;

    // todo: to be implemented
    return true;
}

void MountPoint::mountCheck()
{
    std::string url(StrWide2MB(m_url));
    if (url.empty())
    {
        m_mountPointPath.clear();
        m_shareName.clear();
        m_proto = EProtocol::Unknown;
        return;
    }
    bool mounted;
    // todo: to be implemented
    /*
    if (mounted)
    {
        m_proto = MountPoint::SchemeToProto(service->getMountScheme());
        StrMB2Wide(service->getMountPath(), m_mountPointPath);
        StrMB2Wide(service->getMountName(), m_shareName);
    }
    else
    {
        m_shareName.clear();
        m_mountPointPath.clear();
        m_proto = EProtocol::Unknown;
    }
    */
}
