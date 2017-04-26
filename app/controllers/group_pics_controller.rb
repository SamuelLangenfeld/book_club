class GroupPicsController < ApplicationController
  def create
    @pic = GroupPic.new(group_pic_params)
    @pic.picture.resize_and_pad(800, 500)
    respond_to do |format|
      if @pic.save
        format.html { redirect_to Book.find(@pic.book_id), notice: 'Note was successfully created.' }
      else
        format.html { render 'static_pages/home' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def group_pic_params
    params.require(:group_pic).permit(:picture, :book_id)
  end

end