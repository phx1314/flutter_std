class ModelXm {
  int total;
  List<RowsListBean> rows;

  ModelXm({this.total, this.rows});

  ModelXm.fromJson(Map<String, dynamic> json) {
    this.total = json['total'];
    this.rows = (json['rows'] as List) != null
        ? (json['rows'] as List).map((i) => RowsListBean.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['rows'] =
        this.rows != null ? this.rows.map((i) => i.toJson()).toList() : null;
    return data;
  }
}

class RowsListBean {
  String ProjNumber;
  String ProjName;
  String DateCreate;
  String ProjDatePlanSend;
  String ProjDateFinishSend;
  String SendDelayNote;
  String ProjDatePlanAccept;
  String ProjDateFinishAccept;
  String AcceptDelayNote;
  String ProjEndTime;
  String ProjGroupEmp;
  String ProjNote;
  String ConStartDate;
  String ConLastDate;
  String LWDXDDate;
  String CustResponName;
  String CreateTime;
  String DeleteTime;
  String AcceptanceModule;
  String ProjTaskContent;
  String CustContact;
  String MoneyBack;
  String UIConfirmDate;
  String SoftwareInfo;
  String WaiweiDanwei;
  String WaiweiSoftwareInfo;
  String WaiweiCompleteDate;
  String ScheduleRequire;
  String XingzhengKongzhi;
  String XingzhengJishi;
  String FlowTime;
  String ProjectEmpName;
  String DatePlanStart;
  String DatePlanFinish;
  String BridgeGuid;
  String ProjPhaseInfo;
  String CustAreaProvinceName;
  String CustAreaCityName;
  String SalesDepName;
  String UseEffects;
  var DevelopPersonDayActual;
  String ServicePersonDayActualCount;
  String ServicePersonDayActualDays;
  String SalesRespEmpName;
  String ProjDevpAreaName;
  String ProjEmpName;
  String ServceStateName;
  String ProjStateName;
  String OutTask;
  String ProjProgressPercent;
  String isFinished;
  String IsFinishAcceptName;
  String AcceptanceModuleName;
  String ProjectLevelName;
  String CustName;
  String opt;
  double FeeEstimate;
  double FeeActualCost;
  double DevelopPersonDay;
  double ServicePersonDay;
  double ProjProgress;
  double UpdateDate;
  double QCDays;
  double SUMSUMDevelopPersonDay;
  double realHours;
  double ChangeTtlDays;
  double EDingTtlDays;
  double ShiHaoDays;
  int Id;
  int ProjEmpId;
  int CustId;
  int ProjTypeId;
  int ProjDevpArea;
  int UseEffect;
  int ProjState;
  int ConRespEmpID;
  int CustAreaProvince;
  int CustAreaCity;
  int SalesDep;
  int SalesRespEmpID;
  int ServceState;
  int ProjectLevel;
  int AppNameVersion;
  int CreateBy;
  int DeleteBy;
  int IsFinishAccept;
  int IsAudit;
  int DataCategory;
  int ContractBillId;
  int UIConfirm;
  int IsWaiwei;
  int XingzhengCategoryId;
  int ProjComplex;
  int FlowID;
  int CreatorDepId;
  int ConId;
  int IsNeedPlan;
  int TempTaskType;
  int ProjStatus;
  int ParentId;
  int BridgeFact;
  int ColAttType6;
  int yanshou;
  int leftDays;
  int PayFee;
  int PayNum;
  int PlanPayNum;
  int outDays;
  int SpotDays;
  int rowNumber;
  String FlowSummary;

  RowsListBean(
      {this.ProjNumber,
      this.FlowSummary,
      this.ProjName,
      this.DateCreate,
      this.ProjDatePlanSend,
      this.ProjDateFinishSend,
      this.SendDelayNote,
      this.ProjDatePlanAccept,
      this.ProjDateFinishAccept,
      this.AcceptDelayNote,
      this.ProjEndTime,
      this.ProjGroupEmp,
      this.ProjNote,
      this.ConStartDate,
      this.ConLastDate,
      this.LWDXDDate,
      this.CustResponName,
      this.CreateTime,
      this.DeleteTime,
      this.AcceptanceModule,
      this.ProjTaskContent,
      this.CustContact,
      this.MoneyBack,
      this.UIConfirmDate,
      this.SoftwareInfo,
      this.WaiweiDanwei,
      this.WaiweiSoftwareInfo,
      this.WaiweiCompleteDate,
      this.ScheduleRequire,
      this.XingzhengKongzhi,
      this.XingzhengJishi,
      this.FlowTime,
      this.ProjectEmpName,
      this.DatePlanStart,
      this.DatePlanFinish,
      this.BridgeGuid,
      this.ProjPhaseInfo,
      this.CustAreaProvinceName,
      this.CustAreaCityName,
      this.SalesDepName,
      this.UseEffects,
      this.DevelopPersonDayActual,
      this.ServicePersonDayActualCount,
      this.ServicePersonDayActualDays,
      this.SalesRespEmpName,
      this.ProjDevpAreaName,
      this.ProjEmpName,
      this.ServceStateName,
      this.ProjStateName,
      this.OutTask,
      this.ProjProgressPercent,
      this.isFinished,
      this.IsFinishAcceptName,
      this.AcceptanceModuleName,
      this.ProjectLevelName,
      this.CustName,
      this.opt,
      this.FeeEstimate,
      this.FeeActualCost,
      this.DevelopPersonDay,
      this.ServicePersonDay,
      this.ProjProgress,
      this.UpdateDate,
      this.QCDays,
      this.SUMSUMDevelopPersonDay,
      this.realHours,
      this.ChangeTtlDays,
      this.EDingTtlDays,
      this.ShiHaoDays,
      this.Id,
      this.ProjEmpId,
      this.CustId,
      this.ProjTypeId,
      this.ProjDevpArea,
      this.UseEffect,
      this.ProjState,
      this.ConRespEmpID,
      this.CustAreaProvince,
      this.CustAreaCity,
      this.SalesDep,
      this.SalesRespEmpID,
      this.ServceState,
      this.ProjectLevel,
      this.AppNameVersion,
      this.CreateBy,
      this.DeleteBy,
      this.IsFinishAccept,
      this.IsAudit,
      this.DataCategory,
      this.ContractBillId,
      this.UIConfirm,
      this.IsWaiwei,
      this.XingzhengCategoryId,
      this.ProjComplex,
      this.FlowID,
      this.CreatorDepId,
      this.ConId,
      this.IsNeedPlan,
      this.TempTaskType,
      this.ProjStatus,
      this.ParentId,
      this.BridgeFact,
      this.ColAttType6,
      this.yanshou,
      this.leftDays,
      this.PayFee,
      this.PayNum,
      this.PlanPayNum,
      this.outDays,
      this.SpotDays,
      this.rowNumber});

  RowsListBean.fromJson(Map<String, dynamic> json) {
    this.ProjNumber = json['ProjNumber'];
    this.ProjName = json['ProjName'];
    this.DateCreate = json['DateCreate'];
    this.ProjDatePlanSend = json['ProjDatePlanSend'];
    this.ProjDateFinishSend = json['ProjDateFinishSend'];
    this.SendDelayNote = json['SendDelayNote'];
    this.ProjDatePlanAccept = json['ProjDatePlanAccept'];
    this.ProjDateFinishAccept = json['ProjDateFinishAccept'];
    this.AcceptDelayNote = json['AcceptDelayNote'];
    this.ProjEndTime = json['ProjEndTime'];
    this.ProjGroupEmp = json['ProjGroupEmp'];
    this.ProjNote = json['ProjNote'];
    this.ConStartDate = json['ConStartDate'];
    this.ConLastDate = json['ConLastDate'];
    this.LWDXDDate = json['LWDXDDate'];
    this.CustResponName = json['CustResponName'];
    this.CreateTime = json['CreateTime'];
    this.DeleteTime = json['DeleteTime'];
    this.AcceptanceModule = json['AcceptanceModule'];
    this.ProjTaskContent = json['ProjTaskContent'];
    this.CustContact = json['CustContact'];
    this.MoneyBack = json['MoneyBack'];
    this.UIConfirmDate = json['UIConfirmDate'];
    this.SoftwareInfo = json['SoftwareInfo'];
    this.WaiweiDanwei = json['WaiweiDanwei'];
    this.WaiweiSoftwareInfo = json['WaiweiSoftwareInfo'];
    this.WaiweiCompleteDate = json['WaiweiCompleteDate'];
    this.ScheduleRequire = json['ScheduleRequire'];
    this.XingzhengKongzhi = json['XingzhengKongzhi'];
    this.XingzhengJishi = json['XingzhengJishi'];
    this.FlowTime = json['FlowTime'];
    this.ProjectEmpName = json['ProjectEmpName'];
    this.DatePlanStart = json['DatePlanStart'];
    this.DatePlanFinish = json['DatePlanFinish'];
    this.BridgeGuid = json['BridgeGuid'];
    this.ProjPhaseInfo = json['ProjPhaseInfo'];
    this.CustAreaProvinceName = json['CustAreaProvinceName'];
    this.CustAreaCityName = json['CustAreaCityName'];
    this.SalesDepName = json['SalesDepName'];
    this.UseEffects = json['UseEffects'];
    this.DevelopPersonDayActual = json['DevelopPersonDayActual'];
    this.ServicePersonDayActualCount = json['ServicePersonDayActualCount'];
    this.ServicePersonDayActualDays = json['ServicePersonDayActualDays'];
    this.SalesRespEmpName = json['SalesRespEmpName'];
    this.ProjDevpAreaName = json['ProjDevpAreaName'];
    this.ProjEmpName = json['ProjEmpName'];
    this.ServceStateName = json['ServceStateName'];
    this.ProjStateName = json['ProjStateName'];
    this.OutTask = json['OutTask'];
    this.ProjProgressPercent = json['ProjProgressPercent'];
    this.isFinished = json['isFinished'];
    this.IsFinishAcceptName = json['IsFinishAcceptName'];
    this.AcceptanceModuleName = json['AcceptanceModuleName'];
    this.ProjectLevelName = json['ProjectLevelName'];
    this.CustName = json['CustName'];
    this.opt = json['opt'];
    this.FlowSummary ??= json['_summary'];
    this.FlowSummary ??= json['FlowSummary'];
    this.FeeEstimate = json['FeeEstimate'];
    this.FeeActualCost = json['FeeActualCost'];
    this.DevelopPersonDay = json['DevelopPersonDay'];
    this.ServicePersonDay = json['ServicePersonDay'];
    this.ProjProgress = json['ProjProgress'];
    this.UpdateDate = json['UpdateDate'];
    this.QCDays = json['QCDays'];
    this.SUMSUMDevelopPersonDay = json['SUM_DevelopPersonDay'];
    this.realHours = json['realHours'];
    this.ChangeTtlDays = json['ChangeTtlDays'];
    this.EDingTtlDays = json['EDingTtlDays'];
    this.ShiHaoDays = json['ShiHaoDays'];
    this.Id = json['Id'];
    this.ProjEmpId = json['ProjEmpId'];
    this.CustId = json['CustId'];
    this.ProjTypeId = json['ProjTypeId'];
    this.ProjDevpArea = json['ProjDevpArea'];
    this.UseEffect = json['UseEffect'];
    this.ProjState = json['ProjState'];
    this.ConRespEmpID = json['ConRespEmpID'];
    this.CustAreaProvince = json['CustAreaProvince'];
    this.CustAreaCity = json['CustAreaCity'];
    this.SalesDep = json['SalesDep'];
    this.SalesRespEmpID = json['SalesRespEmpID'];
    this.ServceState = json['ServceState'];
    this.ProjectLevel = json['ProjectLevel'];
    this.AppNameVersion = json['AppNameVersion'];
    this.CreateBy = json['CreateBy'];
    this.DeleteBy = json['DeleteBy'];
    this.IsFinishAccept = json['IsFinishAccept'];
    this.IsAudit = json['IsAudit'];
    this.DataCategory = json['DataCategory'];
    this.ContractBillId = json['ContractBillId'];
    this.UIConfirm = json['UIConfirm'];
    this.IsWaiwei = json['IsWaiwei'];
    this.XingzhengCategoryId = json['XingzhengCategoryId'];
    this.ProjComplex = json['ProjComplex'];
    this.FlowID = json['FlowID'];
    this.CreatorDepId = json['CreatorDepId'];
    this.ConId = json['ConId'];
    this.IsNeedPlan = json['IsNeedPlan'];
    this.TempTaskType = json['TempTaskType'];
    this.ProjStatus = json['ProjStatus'];
    this.ParentId = json['ParentId'];
    this.BridgeFact = json['BridgeFact'];
    this.ColAttType6 = json['ColAttType6'];
    this.yanshou = json['yanshou'];
    this.leftDays = json['leftDays'];
    this.PayFee = json['PayFee'];
    this.PayNum = json['PayNum'];
    this.PlanPayNum = json['PlanPayNum'];
    this.outDays = json['outDays'];
    this.SpotDays = json['SpotDays'];
    this.rowNumber = json['row_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProjNumber'] = this.ProjNumber;
    data['ProjName'] = this.ProjName;
    data['DateCreate'] = this.DateCreate;
    data['ProjDatePlanSend'] = this.ProjDatePlanSend;
    data['ProjDateFinishSend'] = this.ProjDateFinishSend;
    data['SendDelayNote'] = this.SendDelayNote;
    data['ProjDatePlanAccept'] = this.ProjDatePlanAccept;
    data['ProjDateFinishAccept'] = this.ProjDateFinishAccept;
    data['AcceptDelayNote'] = this.AcceptDelayNote;
    data['ProjEndTime'] = this.ProjEndTime;
    data['ProjGroupEmp'] = this.ProjGroupEmp;
    data['ProjNote'] = this.ProjNote;
    data['ConStartDate'] = this.ConStartDate;
    data['ConLastDate'] = this.ConLastDate;
    data['LWDXDDate'] = this.LWDXDDate;
    data['CustResponName'] = this.CustResponName;
    data['CreateTime'] = this.CreateTime;
    data['DeleteTime'] = this.DeleteTime;
    data['AcceptanceModule'] = this.AcceptanceModule;
    data['ProjTaskContent'] = this.ProjTaskContent;
    data['CustContact'] = this.CustContact;
    data['MoneyBack'] = this.MoneyBack;
    data['UIConfirmDate'] = this.UIConfirmDate;
    data['SoftwareInfo'] = this.SoftwareInfo;
    data['WaiweiDanwei'] = this.WaiweiDanwei;
    data['WaiweiSoftwareInfo'] = this.WaiweiSoftwareInfo;
    data['WaiweiCompleteDate'] = this.WaiweiCompleteDate;
    data['ScheduleRequire'] = this.ScheduleRequire;
    data['XingzhengKongzhi'] = this.XingzhengKongzhi;
    data['XingzhengJishi'] = this.XingzhengJishi;
    data['FlowTime'] = this.FlowTime;
    data['ProjectEmpName'] = this.ProjectEmpName;
    data['DatePlanStart'] = this.DatePlanStart;
    data['DatePlanFinish'] = this.DatePlanFinish;
    data['BridgeGuid'] = this.BridgeGuid;
    data['ProjPhaseInfo'] = this.ProjPhaseInfo;
    data['CustAreaProvinceName'] = this.CustAreaProvinceName;
    data['CustAreaCityName'] = this.CustAreaCityName;
    data['SalesDepName'] = this.SalesDepName;
    data['UseEffects'] = this.UseEffects;
    data['DevelopPersonDayActual'] = this.DevelopPersonDayActual;
    data['ServicePersonDayActualCount'] = this.ServicePersonDayActualCount;
    data['ServicePersonDayActualDays'] = this.ServicePersonDayActualDays;
    data['SalesRespEmpName'] = this.SalesRespEmpName;
    data['ProjDevpAreaName'] = this.ProjDevpAreaName;
    data['ProjEmpName'] = this.ProjEmpName;
    data['ServceStateName'] = this.ServceStateName;
    data['ProjStateName'] = this.ProjStateName;
    data['OutTask'] = this.OutTask;
    data['ProjProgressPercent'] = this.ProjProgressPercent;
    data['isFinished'] = this.isFinished;
    data['IsFinishAcceptName'] = this.IsFinishAcceptName;
    data['AcceptanceModuleName'] = this.AcceptanceModuleName;
    data['ProjectLevelName'] = this.ProjectLevelName;
    data['CustName'] = this.CustName;
    data['opt'] = this.opt;
    data['FeeEstimate'] = this.FeeEstimate;
    data['FeeActualCost'] = this.FeeActualCost;
    data['DevelopPersonDay'] = this.DevelopPersonDay;
    data['ServicePersonDay'] = this.ServicePersonDay;
    data['ProjProgress'] = this.ProjProgress;
    data['UpdateDate'] = this.UpdateDate;
    data['QCDays'] = this.QCDays;
    data['SUM_DevelopPersonDay'] = this.SUMSUMDevelopPersonDay;
    data['realHours'] = this.realHours;
    data['ChangeTtlDays'] = this.ChangeTtlDays;
    data['EDingTtlDays'] = this.EDingTtlDays;
    data['ShiHaoDays'] = this.ShiHaoDays;
    data['Id'] = this.Id;
    data['ProjEmpId'] = this.ProjEmpId;
    data['CustId'] = this.CustId;
    data['ProjTypeId'] = this.ProjTypeId;
    data['ProjDevpArea'] = this.ProjDevpArea;
    data['UseEffect'] = this.UseEffect;
    data['ProjState'] = this.ProjState;
    data['ConRespEmpID'] = this.ConRespEmpID;
    data['CustAreaProvince'] = this.CustAreaProvince;
    data['CustAreaCity'] = this.CustAreaCity;
    data['SalesDep'] = this.SalesDep;
    data['SalesRespEmpID'] = this.SalesRespEmpID;
    data['ServceState'] = this.ServceState;
    data['ProjectLevel'] = this.ProjectLevel;
    data['AppNameVersion'] = this.AppNameVersion;
    data['CreateBy'] = this.CreateBy;
    data['DeleteBy'] = this.DeleteBy;
    data['IsFinishAccept'] = this.IsFinishAccept;
    data['IsAudit'] = this.IsAudit;
    data['DataCategory'] = this.DataCategory;
    data['ContractBillId'] = this.ContractBillId;
    data['UIConfirm'] = this.UIConfirm;
    data['IsWaiwei'] = this.IsWaiwei;
    data['XingzhengCategoryId'] = this.XingzhengCategoryId;
    data['ProjComplex'] = this.ProjComplex;
    data['FlowID'] = this.FlowID;
    data['CreatorDepId'] = this.CreatorDepId;
    data['ConId'] = this.ConId;
    data['IsNeedPlan'] = this.IsNeedPlan;
    data['TempTaskType'] = this.TempTaskType;
    data['ProjStatus'] = this.ProjStatus;
    data['ParentId'] = this.ParentId;
    data['BridgeFact'] = this.BridgeFact;
    data['ColAttType6'] = this.ColAttType6;
    data['yanshou'] = this.yanshou;
    data['leftDays'] = this.leftDays;
    data['PayFee'] = this.PayFee;
    data['PayNum'] = this.PayNum;
    data['PlanPayNum'] = this.PlanPayNum;
    data['outDays'] = this.outDays;
    data['SpotDays'] = this.SpotDays;
    data['row_number'] = this.rowNumber;
    return data;
  }
}
