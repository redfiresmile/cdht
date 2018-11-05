<?php

namespace App\Http\Controllers\Admin;

use App\Http\Resources\CommonCollection;
use App\Models\Role;
use App\Validates\RoleValidate;
use Illuminate\Http\Request;

class RolesController extends AdminController
{
    public function __construct()
    {
        parent::__construct();
        $this->middleware('auth:api');
    }

    public function roleList(Request $request, Role $role)
    {
        $search_data = json_decode($request->get('search_data'), true);
        $name = isset_and_not_empty($search_data, 'name');
        if ($name) {
            $role = $role->columnLike('name', $name);
        }

        $order_by = isset_and_not_empty($search_data, 'order_by');
        if ($order_by) {
            $order_by = explode(',', $order_by);
            $role = $role->orderBy($order_by[0], $order_by[1]);
        }

        return new CommonCollection($role->get());
    }

    public function show(Role $role)
    {
        return $this->success($role);
    }

    public function addEdit(Request $request, Role $role, RoleValidate $validate)
    {
        $update_data = $request->only('id', 'name', 'guard_name', 'description');
        $role_id = $request->post('id', 0);
        if ($role_id > 0) {
            $role = $role->findOrFail($role_id);
            $rest_validate = $validate->updateValidate($update_data, $role_id);
        } else {
            $rest_validate = $validate->storeValidate($update_data);
        }

        if ($rest_validate['status'] === false) return $this->failed($rest_validate['message']);

        $res = $role->saveData($update_data);

        if ($res) return $this->message('操作成功');
        return $this->failed('内部错误');
    }

    public function getRolePermissions(Role $role)
    {
        $permissions = $role->permissions()->get();
        $return = [];
        $permissions->each(function ($per) use (&$return) {
            $return[] = strval($per->id);
        });

        return $this->success($return);
    }

    public function giveRolePermissions(Request $request, Role $role)
    {
        $permissions = $request->post('permission');
        $role->syncPermissions($permissions);
        return $this->message('权限分配成功');
    }

    public function allRoles(Role $role)
    {
        $roles = $role->get();
        $return = [];
        $roles->each(function ($per) use (&$return) {
            $return[] = [
                'key' => strval($per->id),
                'label' => $per->name,
                'description' => $per->description
            ];
        });
        return $this->success($return);
    }

    public function destroy(Role $role, RoleValidate $roleValidate)
    {
        if (!$role) return $this->failed('找不到角色', 404);
        $rest_destroy_validate = $roleValidate->destroyValidate($role);
        if ($rest_destroy_validate['status'] === true) {
            $rest_destroy = $role->destroyRole();
            if ($rest_destroy['status'] === true) return $this->message($rest_destroy['message']);
            return $this->failed($rest_destroy['message'], 500);
        } else {
            return $this->failed($rest_destroy_validate['message']);
        }
    }
}
