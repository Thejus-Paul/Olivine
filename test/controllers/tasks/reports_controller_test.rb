# frozen_string_literal: true

require "test_helper"

class Tasks::ReportsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @headers = headers(@user)
  end

  def test_should_create_report
    post(report_path, headers: @headers)
    @user.reload
    assert @user.report.attached?
  end

  def test_should_download_report
    pdf_data = "Sample PDF content"
    pdf_file = Tempfile.new(["task_report", ".pdf"])
    pdf_file.write(pdf_data)
    pdf_file.rewind

    report = ActiveStorage::Blob.create_and_upload!(
      io: pdf_file,
      filename: "olivine_task_report.pdf",
      content_type: "application/pdf"
    )

    @user.report.attach(report)
    get(download_report_path, headers: @headers)

    assert_response :success
    assert_equal "application/pdf", response.content_type
  end

  def test_should_not_download_report_if_no_report_is_generated
    get(download_report_path, headers: @headers)
    assert_response :not_found
  end
end
