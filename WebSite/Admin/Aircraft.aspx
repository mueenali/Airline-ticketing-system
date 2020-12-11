<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPage.master"  AutoEventWireup="true" CodeFile="Aircraft.aspx.cs" Inherits="Admin_Aircraft" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" Runat="Server">
    <div id="app">
        <br />
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Add/Update</h4>
                    </div>
                    <div class="modal-body">
                       <div class="panel panel-default">
                           <div class="panel-body">
                               <label>Id: {{model.id}}</label>
                               <hr />
                               <label>Aircraft Model</label>
                               <input type="text" class="form-control" v-model="model.model" />
                           </div>
                       </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" v-on:click="decide" data-dismiss="modal">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-10">
                <h4>Aircrafts
                            <button class="btn btn-primary btn-sm" v-on:click="reset"  data-toggle="modal" data-target="#myModal">
                                Add New
                            </button>
                    <button class="btn btn-primary btn-sm" v-on:click="loadAll">
                               Test
                            </button>
                </h4>
            </div>
            <div class="col-md-2">
                <input type="text" class="form-control" value="Search" />
            </div>
        </div>
        <hr />
            <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example" v-if="ajaxData.length > 0">
            <thead>
                <tr>
                    <th style="text-align:center;">Id</th>
                    <th style="text-align:center;">Model</th>
                    <th style="text-align:center;">Update</th>
                    <th style="text-align:center;">Delete</th>
                </tr>
            </thead>
            <tbody style="text-align:center;">
                <tr v-for="item, index in ajaxData">
                    <td>{{item.Id}}</td>
                    <td>{{item.Model}}</td>
                    <td><button  class="btn btn-sm btn-info" v-on:click="find(item.Id)">Update</button></td>
                    <td><button class="btn btn-sm btn-danger" v-on:click="del(index)">Delete</button></td>
                </tr>
            </tbody>
        </table>
        <button class="btn btn-sm btn-success disabled">Next</button>
        <button class="btn btn-sm btn-success disabled">Previous</button>
    </div>
</asp:Content>

<asp:Content ID="scripts" ContentPlaceHolderID="scripts" Runat="Server">
        <script src="/Content/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="/Content/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
    <script src="/Content/vendor/datatables-responsive/dataTables.responsive.js"></script>
    <script>
        var vue = new Vue({
            el: '#app',
            data: {
                begin: 0,
                end: 5,
                model: {
                    id: 0,
                    model: ""
                },
                ajaxData: []
            },
            computed: {
                getData: function () {
                    return this.ajaxData;
                }
            },
            methods: {
                update: function () {
                    var scope = this;
                    axios.put('http://localhost:52014/api/AircraftApi/Put', this.model);
                    var i = this.ajaxData.find(function (e) { return e.Id == scope.model.id; });
                    i.Model = this.model.model;
                },
                del: function (id) {
                    var scope = this;
                    axios.delete(`http://localhost:52014/api/AircraftApi/${this.ajaxData[id].Id}`).then(function () {
                        scope.ajaxData.splice(id, 1);
                    });
                },
                post: function () {
                    axios.post('http://localhost:52014/api/AircraftApi/Post', this.model);
                    this.ajaxData.push(this.model);
                },
                loadAll: function () {
                    var scope = this;
                    axios.get('http://localhost:52014/api/AircraftApi', { headers: { accept: 'application/json' } }).then(function (data) {
                        console.log(data.data);
                        scope.ajaxData = data.data;
                    });
                },
                find: function (id) {
                    var scope = this;
                    axios.get(`http://localhost:52014/api/AircraftApi/${id}`, { headers: { accept: 'application/json' } }).then(function (data) {
                        var value = data.data;
                        if (value != null) {
                            scope.model.model = value.Model;
                            scope.model.id = value.Id;
                        }
                        $('#myModal').modal();
                    });
                },
                reset: function () {
                    this.model.id = 0;
                    this.model.model = "";
                },
                decide: function () {
                    if (this.model.id > 0) {
                        this.update();
                    }
                    else {
                        this.post();
                    }
                }
            },
            mounted: function () {
                this.loadAll();
                  $('#dataTables-example').DataTable({
                        responsive: true
                   });
            }
        })
    </script>
</asp:Content>