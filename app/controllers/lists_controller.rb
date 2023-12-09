class ListsController < ApplicationController
  def new
    #viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する
    @list = List.new#インスタンス変数で入力する
  end

  def create
    @list = List.new(list_params) # １.&2. データを受け取り新規登録するためのインスタンス作成
    if @list.save# 3. データをデータベースに保存するためのsaveメソッド実行
      flash[:notice] = "投稿に成功しました。"
      redirect_to list_path(@list.id)# 4. トップ画面へリダイレクト
    else
      flash.now[:alert] = "投稿に失敗しました。"#alertに変更
      render :new
    end
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end

  def destroy
    list = List.find(params[:id])#データ（レコード）を一個取得
    list.destroy#データ（レコード）を削除
    redirect_to '/lists'#投稿一覧へリダイレクト
  end

  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)#トップ画面へリダイレクト
  end

  private

  # ストロングパラメータ
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end
