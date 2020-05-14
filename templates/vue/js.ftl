import request from '@/utils/request'

//分页查询
export function pageQuery(data) {
  return request({
    url: '/admin/${humpTableName!}/pageQuery',
    method: 'post',
    data
  })
}

//查所有
export function query(data) {
  return request({
    url: '/admin/${humpTableName!}/query',
    method: 'post',
    data
  })
}

//单删除
export function deleteById(params) {
  return request({
    url: '/admin/${humpTableName!}/deleteById',
    method: 'post',
    params
  })
}

//批量删除
export function deleteBatch(data) {
  return request({
    url: '/admin/${humpTableName!}/deleteBatch',
    method: 'post',
    data
  })
}

//获取详情
export function findById(params) {
  return request({
    url: '/admin/${humpTableName!}/selectById',
    method: 'post',
    params
  })
}

//修改
export function update(data) {
  return request({
    url: '/admin/${humpTableName!}/update',
    method: 'post',
    data
  })
}

//新增
export function save(data) {
  return request({
    url: '/admin/${humpTableName!}/insert',
    method: 'post',
    data
  })
}

// excel 导入
export function importExcel(params) {
  return request({
    url: '/admin/${humpTableName!}/importFromExcel',
    method: 'post',
    params
  })
}

// excel导出
export function exportExcel() {
  return request({
    url: '/admin/${humpTableName!}/exportExcel',
    method: 'post'
  })
}