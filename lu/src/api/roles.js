import axios from '@/libs/api.request'

// =============== privileges/roles/list.vue =========================
export const getTableData = (searchData) => {
  return axios.request({
    url: '/api/admin/roles',
    params: {
      search_data: JSON.stringify(searchData)
    },
    method: 'get'
  })
}

export const getAllPermission = () => {
  return axios.request({
    url: '/api/admin/all_permissions',
    method: 'get'
  })
}


export const addEditRole = (saveData) => {
  return axios.request({
    url: '/api/admin/roles',
    data: saveData,
    method: 'post'
  })
}


export const getRolePermissions = (roleId) => {
  return axios.request({
    url: 'api/admin/roles/' + roleId + '/permissions',
    method: 'get'
  })
}

export const giveRolePermission = (roleId,permissions) => {
  return axios.request({
    url: '/api/admin/give/' + roleId + '/permissions',
    data: {
      permission: permissions
    },
    method: 'post'
  })
}

export const deleteRole = (role) => {
  return axios.request({
    url: '/api/admin/roles/' + role,
    method: 'delete'
  })
}

// =============== privileges/roles/components/edit-role.vue =========================

export const getRoleInfoById = (role) => {
  return axios.request({
    url: '/api/admin/roles/' + role,
    method: 'get'
  })
}
