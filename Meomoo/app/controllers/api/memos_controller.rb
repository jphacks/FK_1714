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
    resNum = 0
    @memos = Memo.all
    p @memos
    p @memos.first.id
    p @memos.second.id
    respond_to do |format|
      format.html # app/views/products/index.html.erb
      #format.json{ render json: @memos.find_by(id: 1).text }
      #format.json { render json: @memos.count}
      for i in 1..(@memos.count-1) do

        require 'net/http'
        require 'uri'

        require 'net/https'
        require 'json'
        # app_id = "b1d8cfe7e9f9778a51342a239ac81389c0ba8bb227030b5e1df6cdc1361dc6bd"
        # request_data = {"app_id" => app_id,"request_id" => "record004","query_pair":[@memos.find_by(id: @memos.count).text, @memos.find_by(id: i).text]}.to_json
        # header = {'Content-type'=>'application/json'}
        #
        # https = Net::HTTP.new('labs.goo.ne.jp', 443)
        # https.use_ssl=true
        # responce = https.post('https://labs.goo.ne.jp/api/similarity', request_data, header)
        # puts responce.body
        # @result = JSON.parse(responce.body)
        # puts @result["score"]

        app_id = "b1d8cfe7e9f9778a51342a239ac81389c0ba8bb227030b5e1df6cdc1361dc6bd"
        request_data = {"app_id" => app_id,"request_id" => "record004","query_pair" => ["#{@memos.find_by(id: @memos.count).text}", "#{@memos.find_by(id: i).text}"]}.to_json
        header = {'Content-type'=>'application/json'}

        https = Net::HTTP.new('labs.goo.ne.jp', 443)
        https.use_ssl=true
        responce = https.post('https://labs.goo.ne.jp/api/similarity', request_data, header)
        @result = JSON.parse(responce.body)
        puts @result["score"]
        p @memos.find_by(id: @memos.count).text+"==="+@memos.find_by(id: i).text
       if @result["score"] >=0.5
          #format.json { render json: 1} # app/views/products/index.json.jbuilder
          #puts("Yes");
          resNum = 1
          break;
        else
          #format.json { render json: 0} # app/views/products/index.json.jbuilder
        end
      end
      if resNum == 1
        puts("Yes")
        format.json { render json: 1}
      else
        format.json { render json: 0}
      end

      # require 'net/http'
      # require 'uri'

      # POSTするだけ
      # res = Net::HTTP.post_form(URI.parse('labs.goo.ne.jp'),{'q' => 'ruby'})
      # puts res.body
      #
      # # 詳細
      # url = URI.parse('labs.goo.ne.jp/')
      # req = Net::HTTP::Post.new(url.path)
      # app_id = "b1d8cfe7e9f9778a51342a239ac81389c0ba8bb227030b5e1df6cdc1361dc6bd"
      # request_data = {"app_id" => app_id,"request_id" => "record004","query_pair" => ["phablet", "ファブレット"]}.to_json
      # req.set_form_data(request_data, ';')
      # res = Net::HTTP.new(url.host, url.port).start do |http|
      #   http.request(req)
      # end
      #
      # puts res.code
      # puts res.body
      #  require 'net/https'
      #  require 'json'
       #


    end
  end

  private
  def create_params
    params.permit(:text)
  end
end
