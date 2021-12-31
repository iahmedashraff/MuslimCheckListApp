//
//  DailyReportVC.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 08/11/2021.
//

import UIKit
import FSCalendar
import FirebaseAuth

class DailyReportVC: UIViewController {
    //MARK: -Constase
    let date = Date()
    var userDateInApp = NSDate()

    var currentProgress = 0
    let screenName = "Daily Reports"
    
    var currentModel: [String: Any]?
    var pray: [DailyReportModel] = []
    //MARK: -Outlets
    
    @IBOutlet weak var imgDone: UIImageView!
    
    @IBOutlet weak var calender: FSCalendar!
    @IBOutlet weak var backView: UIView!{
        didSet{
            backView.layer.shadowColor = UIColor.black.cgColor
            backView.layer.shadowOffset = CGSize(width: 3, height: 3)
            backView.layer.shadowOpacity = 0.2
            
        }
    }
    
    @IBOutlet weak var progerssBar: ProgressNIB!
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncDataWithPregress();

    }
    //MARK: -IBActions

    
    
    //MARK: -Helper Functions
    func selectDay(){
        
    }
    func getDate() -> String {
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day], from: Date())
        let year = components.year
        let month = components.month
        let day = components.day
        let dateString = String(year!) + "-" + String(month!) + "-" + String(day!)
        return dateString
    }
    func syncDataWithPregress(){
        guard let userID = Auth.auth().currentUser?.uid else {return}
        
        
        let docRef = db.collection("App Users").document(userID).collection("Dates").document("\(getDate())")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data() as? [String: Any]
                self.currentModel = data
                self.progerssBar.lblNumberOne.text = "\(data!.keys.count)"
                self.progerssBar.progressBar.progress = Float(data!.keys.count) / Float(self.pray.count)
            }else {
                print("Document does not exist")
            }
        }
    }

    

    func setupUI(){
        
        calender.scrollDirection = .horizontal
        calender.scope = .week
        calender.locale = Locale(identifier: "ar")
        calender.appearance.headerTitleFont = UIFont(name: "Almarai-Regular", size: 17)
        calender.appearance.weekdayFont = UIFont(name: "Almarai-Regular", size: 13)
        
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day], from: date)
        let year = components.year
        let month = components.month
        let day = components.day
        let dateString = String(year!) + "-" + String(month!) + "-" + String(day!)
        
        lblDate.text = dateString
        
        //PregressBar
        progerssBar.progressBar.trackTintColor = UIColor(hexString: "#ACB1B0")
        progerssBar.progressBar.progressTintColor = UIColor(hexString: "#15C3C0")
        progerssBar.lblDay.textColor = UIColor.black
        progerssBar.lblNumberOne.textColor = UIColor.black
        progerssBar.lblDay.font = UIFont(name: "Almarai-Regular", size: 16.0)
        
    }
    func setupData(){
        let fajrSuna = DailyReportModel()
        fajrSuna.id = 1
        fajrSuna.fbKey = "SonaFajr"
        fajrSuna.prayName = "سنة صلاة الفجر"
        fajrSuna.isSelected = false
        pray.append(fajrSuna)
        
        let fajr = DailyReportModel()
        fajr.id = 1
        fajr.fbKey = "Fajr"
        fajr.prayName = "صلاة الفجر"
        fajr.isSelected = false
        pray.append(fajr)
        
        let duha = DailyReportModel()
        duha.id = 1
        duha.fbKey = "Duha"
        duha.prayName = "صلاة الضحي"
        duha.isSelected = false
        pray.append(duha)
        
        let duhrSona = DailyReportModel()
        duhrSona.id = 1
        duhrSona.fbKey = "Sona_Duhr"
        duhrSona.prayName = "سنة صلاة الظهر"
        duhrSona.isSelected = false
        pray.append(duhrSona)
        
        let duhr = DailyReportModel()
        duhr.id = 1
        duhr.fbKey = "Duhr"
        duhr.prayName = "صلاة الظهر"
        duhr.isSelected = false
        pray.append(duhr)
        
        let asr = DailyReportModel()
        asr.id = 1
        asr.fbKey = "Asr"
        asr.prayName = "صلاة العصر"
        asr.isSelected = false
        pray.append(asr)
        
        let majreebSona = DailyReportModel()
        majreebSona.id = 1
        majreebSona.fbKey = "Sona_Maghreb"
        majreebSona.prayName = "سنة صلاة المغرب"
        majreebSona.isSelected = false
        pray.append(majreebSona)
        
        let majreeb = DailyReportModel()
        majreeb.id = 1
        majreeb.fbKey = "Maghreb"
        majreeb.prayName = "صلاة المغرب"
        majreeb.isSelected = false
        pray.append(majreeb)
        
        let ishaSona = DailyReportModel()
        ishaSona.id = 1
        ishaSona.fbKey = "Sona_Isha"
        ishaSona.prayName = "سنه صلاة العشاء"
        ishaSona.isSelected = false
        pray.append(ishaSona)
        
        let isha = DailyReportModel()
        isha.id = 1
        isha.fbKey = "Isha"
        isha.prayName = "صلاة العشاء"
        isha.isSelected = false
        pray.append(isha)
        
        let morningZekr = DailyReportModel()
        morningZekr.id = 1
        morningZekr.fbKey = "Morning_Zekr"
        morningZekr.prayName = "أذكار الصباح"
        isha.isSelected = false
        pray.append(morningZekr)
        
        let nightZekr = DailyReportModel()
        nightZekr.id = 1
        nightZekr.fbKey = "Night_Zekr"
        nightZekr.prayName = "أذكار المساء"
        nightZekr.isSelected = false
        pray.append(nightZekr)
        
        let sleepZekr = DailyReportModel()
        sleepZekr.id = 1
        sleepZekr.fbKey = "Sleep_Zekr"
        sleepZekr.prayName = "أذكار النوم"
        sleepZekr.isSelected = false
        pray.append(sleepZekr)
        
        let eatZekr = DailyReportModel()
        eatZekr.id = 1
        eatZekr.fbKey = "Eat_Zekr"
        eatZekr.prayName = "أذكار قبل الأكل"
        eatZekr.isSelected = false
        pray.append(eatZekr)
        
        let ablutionZekr = DailyReportModel()
        ablutionZekr.id = 1
        ablutionZekr.fbKey = "Ablution_Zekr"
        ablutionZekr.prayName = "أذكار الوضوء"
        ablutionZekr.isSelected = false
        pray.append(ablutionZekr)
    }
    
}
extension DailyReportVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DailyReportTViewCell
        let item = pray[indexPath.row]
        cell.lblPray.text = item.prayName
        cell.lblRakaat.text = item.rakaatName
        cell.selectionStyle = .none
        if (item.id == 1) {
            if self.currentModel?[item.fbKey ?? ""] != nil {
                item.isSelected = true
                cell.imgDone.image  = UIImage(named: "correct")

            }else {
                item.isSelected = false
                cell.imgDone.image  = UIImage(named: "notdone")


            }
        }
        return cell
    }
    
    
}


