<?php

namespace App\Http\Controllers\Admin;

use App\Http\Resources\CommonCollection;
use App\Models\Article;
use App\Validates\ArticleValidate;
use Illuminate\Http\Request;
use Auth;

class ArticlesController extends AdminController
{
    public function __construct()
    {
        parent::__construct();
        $this->middleware('auth:api');
    }

    public function articleList(Request $request, Article $article)
    {
        $per_page = $request->get('per_page', 10);
        $search_data = json_decode($request->get('search_data'), true);
        $filter = 'default';
        $user_id = 0;
        $title = isset_and_not_empty($search_data, 'title');
        $tag_id = 0;
        $category_id = isset_and_not_empty($search_data, 'category_id');
        $recommend = isset_and_not_empty($search_data, 'recommend');
        $top = isset_and_not_empty($search_data, 'top');
        $enable = isset_and_not_empty($search_data, 'enable');
        $year = '';
        $month = '';
        $order = 'created_at';
        $order_type = 'desc';

        $order_by = isset_and_not_empty($search_data, 'order_by');
        if ($order_by) {
            $order_by = explode(',', $order_by);
            $order = $order_by[0];
            $order_type = $order_by[1];
        }

        $list = $article->getArticlesWithFilter($filter, $user_id, $title, $tag_id, $category_id, $recommend, $top, $enable, $year, $month, $order, $order_type, $per_page);
        return new CommonCollection($list);
    }


    public function show(Article $article)
    {
        $article_tag = $article->tags->toArray();

        $article->tagids = array_column($article_tag, 'id');
        return $this->success($article);
    }

    public function store(Request $request, Article $article, ArticleValidate $validate)
    {
        $insert_data = $request->all();
        if(!isset_and_not_empty($insert_data,'access_value')) {
           unset($insert_data['access_value']);
        }
        $insert_data = array_merge($insert_data, ['created_year' => date('Y'), 'created_month' => date('m')]);

        if (isset($insert_data['cover_image']['attachment_id'])) {
            $attachement_id = $insert_data['cover_image']['attachment_id'];
        } else {
            $attachement_id = 0;
        }
        $insert_data['cover_image'] = $attachement_id;

        $rest_validate = $validate->storeValidate($insert_data);

        if ($rest_validate['status'] === false) return $this->failed($rest_validate['message']);


        $res = $article->storeArticle($insert_data);
        if ($res['status'] === true) return $this->message($res['message']);
        return $this->failed($res['message']);
    }

    public function update(Request $request, Article $article, ArticleValidate $validate)
    {
        if (!$article) return $this->failed('找不到数据', 404);

        $update_data = $request->all();
        if(!isset_and_not_empty($update_data,'access_value')) {
            unset($update_data['access_value']);
        }

        if (isset($update_data['cover_image']['attachment_id'])) {
            $attachement_id = $update_data['cover_image']['attachment_id'];
        } else {
            $attachement_id = 0;
        }
        $update_data['cover_image'] = $attachement_id;

        $rest_validate = $validate->updateValidate($update_data, $article->id);

        if ($rest_validate['status'] === false) return $this->failed($rest_validate['message']);


        $res = $article->updateArticle($update_data);
        if ($res['status'] === true) return $this->message($res['message']);
        return $this->failed($res['message']);
    }

    public function destroy(Article $article, ArticleValidate $validate)
    {
        if (!$article) return $this->failed('找不到数据', 404);
        $rest_destroy_validate = $validate->destroyValidate($article);
        if ($rest_destroy_validate['status'] === true) {
            $rest_destroy = $article->destroyArticle();
            if ($rest_destroy['status'] === true) return $this->message($rest_destroy['message']);
            return $this->failed($rest_destroy['message'], 500);
        } else {
            return $this->failed($rest_destroy_validate['message']);
        }
    }
}
