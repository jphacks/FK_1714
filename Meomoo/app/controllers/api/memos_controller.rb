class Api::MemosController < ApplicationController
  # skip_before_filter :verify_authenticity_token, only: :create # どうやらこの記述が必要
  protect_from_forgery with: :null_session

  def create
    p "登録完了！!!!!!"

    memo = Memo.new(create_params)

    # エラー処理
    unless memo.save # もし、memoが保存できなかったら
      @error_message = [memo.errors.full_messages].compact # エラーが入ってるインスタンス変数を定義
    end
  end
  
  def show
    @memos = Memo.all
    p @memos
    respond_to do |format|
      format.html # app/views/products/index.html.erb
      format.json { render json: @memos} # app/views/products/index.json.jbuilder
    end
  end

  private
  def create_params
    params.permit(:text)
  end
end
