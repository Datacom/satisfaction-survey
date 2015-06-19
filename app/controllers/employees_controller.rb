class EmployeesController < ApplicationController
  before_filter :authenticate_user!, except: [:update_daily_report, :daily_report]
  before_action :set_employee, only: [:show, :edit, :update, :destroy,]

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    @reports = @employee.daily_reports.completed
    @date = Date.parse(params[:date]) if params[:date]
    @date ||= Date.today
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  def unit_show
    @employees = Employee.where(unit: params[:name])
    @date = Date.parse(params[:date]) if params[:date]
    @date ||= Date.today
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def daily_report
    @report = DailyReport.find_by(access_token: params[:access_token])
    if @report && @report.completed?
      render 'completed'
    else
      render nothing: true, status: 403 if @report.nil?
    end
  end

  def show_daily_report
    @report = DailyReport.find_by(id: params[:id])
  end

  def email_report
    @employee = Employee.find(params[:employee_id])
    @report = @employee.daily_reports.create
    EmployeeMailer.daily_report(@employee, @report).deliver!
    render nothing: true, status: 200
  end

  def update_daily_report
    @report = DailyReport.find_by(access_token: params[:access_token])
    unless @report.completed?
      @report.update_attributes(params[:daily_report].permit(:comment, :score))
      render nothing: true, status: 200
    else
      render nothing: true, status: 403
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:email, :name, :user_id, :daily_report, :unit)
    end
end
