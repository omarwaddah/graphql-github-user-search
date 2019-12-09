class PagesController < ApplicationController
  def search
    if params[:search].blank?
      if !params[:error].blank?
        puts("HEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEY")
        @error = params[:error]
      else
        redirect_to(root_path, alert: "Empty field!") and return
      end
    else
      @name = params[:search].downcase
      redirect_to(controller: repositories_path, "name"=>@name) and return
    end
  end
end