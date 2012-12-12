class RestApiEnhancerController < ApplicationController
  unloadable

  before_filter :find_issue, :only => [:watchers]
  before_filter :authorize
  accept_api_auth :watchers


  def find_issue
    @issue = Issue.find(params[:id])
    raise Unauthorized unless @issue.visible?
    @project = @issue.project
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def watchers
    @errors = []
    if User.current.admin?
      user_ids = params[:user_ids]
      if user_ids != nil
        if Rails::VERSION::MAJOR >= 3
          Watcher.where(:watchable_type => 'Issue', :watchable_id => @issue.id).delete_all
        else
          Watcher.delete_all(["watchable_type = ? AND watchable_id = ?", 'Issue', @issue.id])
        end
        user_ids = user_ids.split ","
        user_ids.each do |user_id|
          user_id = user_id.to_i
          begin
            Watcher.create(:watchable_type => 'Issue', :watchable_id => @issue.id, :user_id => user_id).save!
          rescue
            @errors += ["user #{user_id}: #{$!}"]
          end
        end
      end

      respond_to do |format|
        format.api
      end
    else
      flash[:error] = 'Permission denied.'
      redirect_to :controller => 'issues', :action => 'index'
    end
  end
end
