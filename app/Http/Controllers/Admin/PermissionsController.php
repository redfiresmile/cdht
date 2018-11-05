<?php

namespace App\Http\Controllers\Admin;

use App\Http\Resources\CommonCollection;
use App\Http\Resources\PermissionResource;
use App\Models\Permission;
use App\Validates\PermissionValidate;
use Illuminate\Http\Request;

class PermissionsController extends AdminController
{
    public function __construct()
    {
        parent::__construct();
        $this->middleware('auth:api');
    }

    public function permissionList(Request $request, Permission $permission)
    {
        $search_data = json_decode($request->get('search_data'), true);
        $name = isset_and_not_empty($search_data, 'name');
        if ($name) {
            $permission = $permission->columnLike('name', $name);
        }

        $order_by = isset_and_not_empty($search_data, 'order_by');
        if ($order_by) {
            $order_by = explode(',', $order_by);
            $permission = $permission->orderBy($order_by[0], $order_by[1]);
        }

        $permissions = $permission->get();

        return new CommonCollection($permissions);
    }

    public function show(Permission $permission)
    {
        return $this->success($permission);
    }


    public function allPermissions(Permission $permission)
    {
        $permissions = $permission->get();
        $return = [];
        $permissions->each(function ($per) use (&$return) {
            $return[] = [
                'key' => strval($per->id),
                'label' => $per->name,
                'description' => $per->description
            ];
        });
        return $this->success($return);
    }

    public function addEdit(Request $request, Permission $permission, PermissionValidate $validate)
    {
        $data = $request->only('id', 'name', 'guard_name', 'description');
        $permission_id = $request->post('id', 0);
        if ($permission_id > 0) {
            $permission = $permission->findOrFail($permission_id);
            $rest_validate = $validate->updateValidate($data, $permission_id);
        } else {
            $rest_validate = $validate->storeValidate($data);
        }


        if ($rest_validate['status'] === false) return $this->failed($rest_validate['message']);

        $res = $permission->saveData($data);
        if ($res) return $this->message('操作成功');
        return $this->failed('内部错误');
    }

    public function destroy(Permission $permission, PermissionValidate $permissionValidate)
    {
        if (!$permission) return $this->failed('找不到权限', 404);
        $rest_destroy_validate = $permissionValidate->destroyValidate($permission);
        if ($rest_destroy_validate['status'] === true) {
            $rest_destroy = $permission->destroyPermission();
            if ($rest_destroy['status'] === true) return $this->message($rest_destroy['message']);
            return $this->failed($rest_destroy['message'], 500);
        } else {
            return $this->failed($rest_destroy_validate['message']);
        }
    }
}
