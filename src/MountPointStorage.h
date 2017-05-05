#pragma once

#include <string>
#include <map>
#include <vector>
#include <WinCompat.h>
#include "MountPoint.h"

class MountPointStorage
{
  public:
    MountPointStorage(const std::wstring& registryFolder);

    static MountPoint PointFactory();

    inline bool valid() const { return m_version != 0; }

    void LoadAll(std::map<std::wstring, MountPoint>& storage);
    bool Save(const MountPoint& point);
    void Delete(const MountPoint& point) const;

  private:
    static const wchar_t* StoragePath;
    static const wchar_t* StorageVersionKey;
    static const DWORD StorageVersion;

    static void GenerateId(std::wstring& id);
    static void Encrypt(const std::wstring& in, std::vector<BYTE>& out);
#ifdef USE_OPENSSL
    static void Encrypt(const std::wstring& keydata, const std::wstring& in,
                        std::vector<BYTE>& out);
#endif
    // Versioning!
    void Decrypt(const std::vector<BYTE>& in, std::wstring& out) const;
#ifdef USE_OPENSSL
    // Versioning!
    void Decrypt(const std::wstring& keydata, const std::vector<BYTE>& in,
                 std::wstring& out) const;
#endif

    // Versioning!
    bool Load(MountPoint& point) const;

    bool SetValue(HKEY folder, const std::wstring& field,
                  const std::vector<BYTE>& value) const;
    bool SetValue(HKEY folder, const std::wstring& field,
                  const std::wstring& value) const;
    bool SetValue(HKEY folder, const std::wstring& field,
                  const DWORD value) const;
    bool GetValue(HKEY folder, const std::wstring& field,
                  std::vector<BYTE>& value) const;
    bool GetValue(HKEY folder, const std::wstring& field,
                  std::wstring& value) const;
    bool GetValue(HKEY folder, const std::wstring& field,
                  DWORD& value) const;

    std::wstring m_registryFolder;
    DWORD m_version;
};
