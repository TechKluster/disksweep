# disksweep
Utility for finding large files in MacOS

**Introduction**  
Struggling with mysterious storage hogs on your Mac? Meet **DiskSweep** – a GitHub repository offering *two complementary utilities* (Python and Bash) to audit disk usage. Whether you prefer scripting flexibility or zero-dependency simplicity, this guide will help you leverage both tools effectively.  

👉 **Repository**: [TechKluster/disksweep](https://github.com/TechKluster/disksweep/tree/main)  

---

### **Why Two Versions?**  
| Feature                | Python Version                          | Bash Version                          |  
|------------------------|-----------------------------------------|---------------------------------------|  
| **Dependencies**       | Requires Python 3.10+                   | None (Native macOS)                   |  
| **Best For**           | Detailed reports, cross-platform        | Quick scans, older macOS versions     |  
| **Customization**      | High (Modular codebase)                 | Medium (Terminal-focused)             |  
| **Speed**              | Moderate                                | Faster for small directories          |  

---

### **Getting Started**  
#### 1. Clone the Repository  
```bash  
git clone https://github.com/TechKluster/disksweep.git  
cd disksweep  
```  

#### 2. Directory Structure  
```  
disksweep/  
├── python/  
│   ├── disksweep.py       # Python script  
│   └── requirements.txt   # Dependencies  
└── bash/  
    └── disksweep.sh       # Bash script  
```  

---

### **Python Utility Deep Dive**  
**Ideal For**: Developers needing granular control  

#### Installation  
```bash  
cd python  
pip install -r requirements.txt  # Installs humanize package  
```  

#### Usage Examples  
1. **Basic Scan (Home Directory >100MB)**:  
   ```bash  
   python3 disksweep.py  
   ```  

2. **Custom Directory + Size**:  
   ```bash  
   python3 disksweep.py -d ~/Downloads -s 500  # 500MB threshold  
   ```  

3. **Interactive Mode**:  
   ```bash  
   python3 disksweep.py -i  
   ```  
   *Prompts for directory/size*  

4. **Generate CSV Report**:  
   ```bash  
   python3 disksweep.py -d ~/Documents --csv report.csv  
   ```  

**Advanced Feature**: Exclude system paths via `--exclude`:  
```bash  
python3 disksweep.py --exclude "Library,node_modules"  
```  

---

### **Bash Utility Deep Dive**  
**Ideal For**: Sysadmins needing instant results  

#### Installation  
```bash  
cd bash  
chmod +x disksweep.sh  
```  

#### Usage Examples  
1. **Quick Home Directory Scan**:  
   ```bash  
   ./disksweep.sh  
   ```  

2. **Target Large Files in Downloads**:  
   ```bash  
   ./disksweep.sh -d ~/Downloads -s 1000  # 1GB+ files  
   ```  

3. **Top 20 Results Only**:  
   ```bash  
   ./disksweep.sh -m 20  
   ```  

4. **Interactive Mode**:  
   ```bash  
   ./disksweep.sh -i  
   ```  

**Pro Tip**: Pipe results to a file for later review:  
```bash  
./disksweep.sh -d ~/Movies > large_media.txt  
```  

---

### **Side-by-Side Workflow**  
*Scenario*: Clean up after Android Studio projects  

#### Python Approach  
```bash  
# Detailed analysis with CSV export  
python3 disksweep.py \  
  -d ~/.android \  
  -s 200 \  
  --csv android_report.csv  
```  

#### Bash Approach  
```bash  
# Instant terminal results  
./disksweep.sh -d ~/.gradle -s 100  
```  

---

### **Customization Guide**  

#### For Python Version  
1. **Modify Output Formatting**:  
   Edit `disksweep.py`’s `print_results()` function.  

2. **Add New Filters**:  
   Extend the `find_large_files()` method to exclude file types:  
   ```python  
   if path.endswith(('.log', '.tmp')):  
       continue  
   ```  

#### For Bash Version  
1. **Change Sorting Behavior**:  
   Modify the `sort` command in Line 52:  
   ```bash  
   sort -h  # Sort ascending instead of descending  
   ```  

2. **Add Exclusion Patterns**:  
   Update the `find` command:  
   ```bash  
   find ... ! -path "*Cache*"  
   ```  

---

### **Troubleshooting**  

#### Python Errors  
- **"ModuleNotFoundError"**:  
  ```bash  
  pip install -r requirements.txt  # Ensure dependencies  
  ```  

- **Permission Issues**:  
  ```bash  
  python3 disksweep.py --exclude "System"  # Skip protected paths  
  ```  

#### Bash Limitations  
- **Large Directories Slow?**:  
  Use more restrictive thresholds:  
  ```bash  
  ./disksweep.sh -s 500  # Only 500MB+ files  
  ```  

- **Hidden Files Not Showing**:  
  ```bash  
  ./disksweep.sh -d ~/.*  # Scan hidden directories  
  ```  

---

### **FAQ**  
**Q1**: Why maintain two versions?  
**A**: Python offers cross-platform/reporting features; Bash provides macOS-native speed.  

**Q2**: How to uninstall?  
**A**: Just delete the cloned repo – no system files modified.  

**Q3**: Can I scan external drives?  
**A**: Yes! Use `-d /Volumes/YourDrive` in either tool.  

---

### **Conclusion**  
Whether you’re a Python enthusiast who loves data exports or a terminal warrior seeking instant insights, DiskSweep’s dual-approach empowers you to:  
- Reclaim gigabytes of wasted space  
- Audit projects/emulator storage  
- Maintain organized development environments  

**Contribute**: Found a bug? Submit a PR or issue on [GitHub](https://github.com/TechKluster/disksweep).  

**Share Your Success**: Tweet your storage savings with `#TechKlusterDiskSweep`!  

---  
*Tags: macOS optimization, Python scripting, Bash utilities, open source, storage management*  
*Meta Description: Learn to use DiskSweep’s Python and Bash utilities to identify and manage large files on macOS. Perfect for developers and power users.*
