# this program fetched data from FRED for median income


import os
import time
import shutil
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from webdriver_manager.chrome import ChromeDriverManager

# State abbreviations used in FRED URLs
state_abbreviations = {
    "Alabama": "ALA", "Alaska": "AKA", "Arizona": "AZA", "Arkansas": "ARA",
    "California": "CAA", "Colorado": "COA", "Connecticut": "CTA", "Delaware": "DEA",
    "Florida": "FLA", "Georgia": "GAA", "Hawaii": "HIA", "Idaho": "IDA", "Illinois": "ILA",
    "Indiana": "INA", "Iowa": "IAA", "Kansas": "KSA", "Kentucky": "KYA", "Louisiana": "LAA",
    "Maine": "MEA", "Maryland": "MDA", "Massachusetts": "MNA", "Michigan": "MIA",
    "Minnesota": "MNA", "Mississippi": "MSA", "Missouri": "MOA", "Montana": "MTA",
    "Nebraska": "NEA", "Nevada": "NVA", "New Hampshire": "NHA", "New Jersey": "NJA",
    "New Mexico": "NMA", "New York": "NYA", "North Carolina": "NCA",
    "North Dakota": "NDA", "Ohio": "OHA", "Oklahoma": "OKA", "Oregon": "ORA",
    "Pennsylvania": "PAA", "Rhode Island": "RIA", "South Carolina": "SCA",
    "South Dakota": "SDA", "Tennessee": "TNA", "Texas": "TXA", "Utah": "UTA",
    "Vermont": "VTA", "Virginia": "VAA", "Washington": "WAA", "West Virginia": "WVA",
    "Wisconsin": "WIA", "Wyoming": "WYA", "Washington D.C.": "DCA"
}

# Base FRED URL
base_url = "https://fred.stlouisfed.org/series/MEHOINUS{}672N"

# Set up download directories
download_dir = os.path.expanduser("~/Downloads")  # Default Chrome download location
output_dir = os.path.expanduser("~/Code/school/regression-analysis/projects/final-project/data")
os.makedirs(output_dir, exist_ok=True)

# Set up Selenium WebDriver
chrome_options = webdriver.ChromeOptions()
prefs = {"download.default_directory": download_dir, "download.prompt_for_download": False}
chrome_options.add_experimental_option("prefs", prefs)
driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=chrome_options)

# Loop through states and download CSV
for state, abbr in state_abbreviations.items():
    url = base_url.format(abbr)
    print(f"Opening: {url}")
    
    driver.get(url)
    time.sleep(3)  # Let page load

    try:
        # Click the "Download" button to open the menu
        download_button = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.ID, "download-button"))
        )
        download_button.click()
        time.sleep(2)  # Wait for dropdown to appear

        # Click the "CSV" option
        csv_button = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.ID, "download-data-csv"))
        )
        csv_button.click()
        time.sleep(3)  # Wait for download to complete

        # Find the latest downloaded file
        # files = [f for f in os.listdir(download_dir) if f.endswith(".csv")]
        # latest_file = max(files, key=lambda f: os.path.getctime(os.path.join(download_dir, f)))

        # # Move it to the output directory and rename it
        # new_filename = f"income_{state}.csv"
        # shutil.move(os.path.join(download_dir, latest_file), os.path.join(output_dir, new_filename))
        # print(f"✅ Downloaded {new_filename}")

    except Exception as e:
        print(f"❌ Failed for {state}: {e}")

# Close Selenium browser
driver.quit()
print(f"✅ All downloads complete. Files saved in: {output_dir}")
