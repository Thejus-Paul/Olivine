# frozen_string_literal: true

require "test_helper"
require "sidekiq/testing"

class ReportsJobTest < ActiveSupport::TestCase
  def setup
    @user = create(:task).assigned_user
  end

  def test_creates_report_file
    Sidekiq::Testing.inline!
    ReportsJob.perform_async(@user.id)

    @user.reload
    assert @user.report.attached?
  end

  def test_purges_existing_report
    Sidekiq::Testing.inline!

    ReportsJob.perform_async(@user.id)
    @user.reload
    assert @user.report.attached?

    ReportsJob.perform_async(@user.id)
    @user.reload
    assert @user.report.attached?
    assert_equal 1, @user.report.attachments.count
  end
end
