<template>
    <div class="app-container">
        <div class="app-buttons">
            <el-row :gutter="20">
                <el-col :span="6" :offset="0">
                    <div>
                        <el-input v-model="pageQueryReq.name" placeholder="请输入关键字"></el-input>
                    </div>
                </el-col>
                <el-col :span="4" :offset="0">
                    <div>
                        <el-button type="info" plain @click="resetQueryReq()">重置</el-button>
                        <el-button type="info" plain @click="fetchPageList()">搜索</el-button>
                    </div>
                </el-col>
                <el-col :span="8" :offset="0">
                    <div>
                        <el-button type="warning" plain @click="toggleSelection(pageQueryRes.row)">全选</el-button>
                        <el-button plain @click="toggleSelection()">取消</el-button>
                        <el-button type="danger" plain @click="deleteRows()">删除</el-button>
                        <el-button plain @click="showSave()">新增</el-button>
                    </div>
                </el-col>
                <el-col :span="2" :offset="0">
                    <div>
                        <el-upload
                                class="upload"
                                action
                                ref="fileRef"
                                :multiple="false"
                                :limit="1"
                                :file-list="excelList"
                                :show-file-list="false"
                                :http-request="uploadExcel"
                        >
                            <el-button plain type="primary">导入</el-button>
                        </el-upload>
                    </div>
                </el-col>
                <el-col :span="2" :offset="0">
                    <div>
                        <el-button type="success" plain @click="exportExcel()">导出</el-button>
                    </div>
                </el-col>
                <el-col :span="2" :offset="0">
                    <div></div>
                </el-col>
            </el-row>
        </div>
        <div class="app-content">
            <el-table
                    ref="mainTable"
                    v-loading="listLoading"
                    :data="pageQueryRes.row"
                    element-loading-text="Loading"
                    border
                    fit
                    highlight-current-row
                    @selection-change="handleSelectionChange"
            >
                >
                <el-table-column align="center" type="selection" width="55"></el-table-column>
                <el-table-column fixed align="center" label="序号" width="95">
                    <template slot-scope="scope">{{ scope.$index +1 }}</template>
                </el-table-column>

                <#list columnInfoList as columnInfo>
                    <el-table-column label="${columnInfo.columnComment!}">
                        <template slot-scope="scope">{{ scope.row.${columnInfo.humpColumnName!} }}</template>
                    </el-table-column>
                </#list>

                <el-table-column fixed="right" label="操作" width="130">
                    <template slot-scope="scope">
                        <el-button @click="showDetail(scope.row)" type="text" size="small">详情</el-button>
                        <el-button @click="showEdit(scope.row)" type="text" size="small">编辑</el-button>
                        <el-button @click="deleteRow(scope.row)" type="text" size="small">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <pagination
                    v-show="pageQueryRes.total>=0"
                    :total="pageQueryRes.total"
                    :page.sync="pageQueryReq.page"
                    :limit.sync="pageQueryReq.size"
                    @pagination="fetchPageList"
            />
        </div>

        <el-dialog
                :width="dialogAttribuite.detail.width"
                title="详情"
                :visible.sync="dialogAttribuite.detail.visible"
                center
        >
            <#list columnInfoList as columnInfo>
                <el-row :gutter="20">
                    <el-col :span="6" :offset="4">
                        <span>${columnInfo.columnComment!}</span>
                    </el-col>
                    <el-col :span="6">
                        <span>{{detail.${columnInfo.humpColumnName!}}}</span>
                    </el-col>
                </el-row>
            </#list>

            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogAttribuite.detail.visible = false">取 消</el-button>
                <el-button
                        type="primary"
                        @click="dialogAttribuite.detail.visible = false;dialogAttribuite.edit.visible = true"
                >修改</el-button>
            </div>
        </el-dialog>

        <el-dialog
                :width="dialogAttribuite.edit.width"
                title="详情"
                :visible.sync="dialogAttribuite.edit.visible"
                center
        >
            <el-form :model="updateReq">
                <#list columnInfoList as columnInfo>
                    <el-form-item :label-width="dialogAttribuite.edit.formWidth" label="${columnInfo.columnComment!}">
                        <el-input v-model="updateReq.${columnInfo.humpColumnName!}" autocomplete="off"></el-input>
                    </el-form-item>
                </#list>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogAttribuite.edit.visible = false">取 消</el-button>
                <el-button type="primary" @click="update">修改</el-button>
            </div>
        </el-dialog>

        <el-dialog
                :width="dialogAttribuite.save.width"
                title="详情"
                :visible.sync="dialogAttribuite.save.visible"
                center
        >
            <el-form :model="insertReq">
                <#list columnInfoList as columnInfo>
                    <el-form-item :label-width="dialogAttribuite.save.formWidth" label="${columnInfo.columnComment!}">
                        <el-input v-model="insertReq.${columnInfo.humpColumnName!}" autocomplete="off"></el-input>
                    </el-form-item>
                </#list>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogAttribuite.save.visible = false">取 消</el-button>
                <el-button type="primary" @click="save">修改</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
    import { downloadFromUrl } from "@/utils/download";
    import Pagination from "@/components/Pagination";
    import { upload } from "@/api/file";
    import {
        //分页查询
        pageQuery,
        //查询所有
        query,
        //详情
        findById,
        //单条删除
        deleteById,
        //批量删除
        deleteBatch,
        //修改
        update,
        //新增
        save,
        //excel导入
        importExcel,
        //excel导出
        exportExcel
    } from "@/api/${humpTableName!}";

    export default {
        components: { Pagination },
        filters: {
            //状态转换
            statusFilter(status) {
                const statusMap = {
                    published: "success",
                    draft: "gray",
                    deleted: "danger"
                };
                return statusMap[status];
            }
        },
        data() {
            return {
                //弹窗
                dialogAttribuite: {
                    detail: {
                        visible: false,
                        width: "600px"
                    },
                    edit: {
                        visible: false,
                        width: "600px",
                        formWidth: "100px"
                    },
                    save: {
                        visible: false,
                        width: "600px",
                        formWidth: "100px"
                    }
                },
                //圈圈
                listLoading: true,
                //分页查询参数
                pageQueryReq: {
                    page: 1,
                    size: 10,
                    name: ""
                },
                //分页响应参数
                pageQueryRes: {
                    total: 0,
                    row: []
                },
                list: [],
                detail: {},
                insertReq: {},
                updateReq: {},
                selectedList: [],
                excelList: []
            };
        },
        created() {
            //查询列表
            this.fetchPageList();
        },
        methods: {
            //分页列表
            fetchPageList() {
                this.listLoading = true;
                pageQuery(this.pageQueryReq)
                    .then(response => {
                        this.pageQueryRes.row = response.data.row;
                        this.pageQueryRes.total = response.data.total;
                        this.listLoading = false;
                    })
                    .catch(error => {
                        this.listLoading = false;
                    });
            },
            //获取所有
            fetchList() {
                query({}).then(response => {
                    this.list = response.data;
                });
            },
            //删单
            deleteRow(row) {
                this.$confirm(
                    "此操作将永久删除:" + row.name + ", 是否继续?",
                    "提示",
                    {
                        confirmButtonText: "确定",
                        cancelButtonText: "取消",
                        type: "warning"
                    }
                )
                    .then(() => {
                        deleteById({ id: row.id }).then(response => {
                            this.$message({
                                type: "success",
                                message: "删除成功!"
                            });
                            this.fetchPageList();
                        });
                    })
                    .catch(() => {
                        this.$message({
                            type: "info",
                            message: "已取消删除"
                        });
                    });
            },
            //删多
            deleteRows() {
                const ids = [];
                this.selectedList.forEach(item => {
                    ids.push(item.id);
                });
                this.$confirm("此操作将永久删除:是否继续?", "提示", {
                    confirmButtonText: "确定",
                    cancelButtonText: "取消",
                    type: "warning"
                })
                    .then(() => {
                        deleteBatch(ids).then(response => {
                            this.$message({
                                type: "success",
                                message: "删除成功!"
                            });
                            this.fetchPageList();
                        });
                    })
                    .catch(() => {
                        this.$message({
                            type: "info",
                            message: "已取消删除"
                        });
                    });
            },
            //修改
            update() {
                console.log(update);
                update(this.updateReq).then(response => {
                    this.dialogAttribuite.edit.visible = false;
                    this.fetchPageList();
                });
            },
            //详情
            showDetail(row) {
                findById({ id: row.id }).then(response => {
                    this.dialogAttribuite.detail.visible = true;
                    this.detail = response.data;
                });
            },
            //显示编辑
            showEdit(row) {
                findById({ id: row.id }).then(response => {
                    this.dialogAttribuite.edit.visible = true;
                    this.updateReq = response.data;
                });
            },
            edit() {
                update(this.updateReq).then(response => {
                    this.dialogAttribuite.edit.visible = false;
                    this.updateReq = {};
                });
            },
            //显示编辑
            showSave() {
                this.dialogAttribuite.save.visible = true;
            },
            save() {
                save(this.insertReq).then(response => {
                    this.dialogAttribuite.save.visible = false;
                    this.insertReq = {};
                    this.fetchPageList();
                });
            },
            //上传
            uploadExcel(param) {
                const file = param.file;
                const formData = new FormData();
                formData.append("file", file);
                upload(formData).then(response => {
                    importExcel(response.data.id).then(response => {
                        this.excelList = [];
                    });
                });
            },
            exportExcel() {
                exportExcel().then(response => {
                    this.downloadFromUrl(response.data);
                });
            },
            resetQueryReq() {
                this.pageQueryReq = {
                    page: 1,
                    size: 10,
                    name: ""
                };
                this.fetchPageList();
            },
            //勾选
            handleSelectionChange(val) {
                this.selectedList = val;
            },
            //全选反选
            toggleSelection(rows) {
                this.selectedList.push(rows);
                if (rows) {
                    rows.forEach(row => {
                        this.$refs.mainTable.toggleRowSelection(row);
                    });
                } else {
                    this.selectedList = [];
                    this.$refs.mainTable.clearSelection();
                }
            }
        }
    };
</script>
<style scoped>
    .app-content {
        margin-top: 10px;
    }
    .el-row {
        margin-bottom: 20px;
    &:last-child {
         margin-bottom: 0;
     }
    }
    .el-row .el-col span {
        font-size: 18px;
    }
</style>