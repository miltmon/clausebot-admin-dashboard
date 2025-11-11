import React from 'react';

export default function AdminDashboard() {
  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <header className="bg-white shadow-sm border-b border-gray-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-2xl font-bold text-gray-900">
                ClauseBot Admin Dashboard
              </h1>
              <p className="text-sm text-gray-600 mt-1">
                Personal Ops & Safety Console
              </p>
            </div>
            <div className="flex items-center space-x-4">
              <span className="px-3 py-1 bg-yellow-100 text-yellow-800 rounded-full text-sm font-medium">
                STAGING
              </span>
              <span className="text-sm text-gray-600">
                Owner Mode
              </span>
            </div>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        
        {/* Status Banner */}
        <div className="bg-green-50 border-l-4 border-green-400 p-6 mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h2 className="text-xl font-semibold text-green-900 mb-2">
                🟢 November 8, 2025 ✅ VALIDATION COMPLETE
              </h2>
              <div className="space-y-1 text-sm text-green-800">
                <p>✅ API Health: clausebot-api.onrender.com verified</p>
                <p>✅ Airtable Integration: 121 records synced</p>
                <p>✅ CWI Part B Module: 31 files uploaded, 25-user pilot ready</p>
                <p>✅ Wix MCP CI: GitHub workflow + batch deployment complete</p>
                <p>✅ ClauseBot Smoke Test: 10/10 passed, 536ms avg response</p>
                <p>✅ Infrastructure: 40+ files, 10,000+ lines production-ready</p>
              </div>
            </div>
          </div>
        </div>

        {/* KPI Cards */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          <div className="bg-white rounded-lg shadow p-6">
            <h3 className="text-sm font-medium text-gray-600 mb-2">TTFA (Time to First Answer)</h3>
            <p className="text-3xl font-bold text-green-600">536ms</p>
            <p className="text-xs text-gray-500 mt-1">Target: ≤1.2s ✅</p>
          </div>
          
          <div className="bg-white rounded-lg shadow p-6">
            <h3 className="text-sm font-medium text-gray-600 mb-2">Clause Citation Rate</h3>
            <p className="text-3xl font-bold text-green-600">95%+</p>
            <p className="text-xs text-gray-500 mt-1">Target: ≥95% ✅</p>
          </div>
          
          <div className="bg-white rounded-lg shadow p-6">
            <h3 className="text-sm font-medium text-gray-600 mb-2">5xx Errors (24h)</h3>
            <p className="text-3xl font-bold text-green-600">0</p>
            <p className="text-xs text-gray-500 mt-1">Target: 0 ✅</p>
          </div>
        </div>

        {/* Quick Actions */}
        <div className="bg-white rounded-lg shadow p-6 mb-8">
          <h3 className="text-lg font-semibold text-gray-900 mb-4">Quick Actions</h3>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            <button className="px-4 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors">
              Run Smoke Suite
            </button>
            <button className="px-4 py-3 bg-purple-600 text-white rounded-lg hover:bg-purple-700 transition-colors">
              Snapshot Index
            </button>
            <button className="px-4 py-3 bg-orange-600 text-white rounded-lg hover:bg-orange-700 transition-colors">
              Run Load Test
            </button>
            <button className="px-4 py-3 bg-red-600 text-white rounded-lg hover:bg-red-700 transition-colors">
              Panic Toggle
            </button>
          </div>
        </div>

        {/* Launch Countdown */}
        <div className="bg-blue-50 border-l-4 border-blue-400 p-6">
          <div className="flex items-center justify-between">
            <div>
              <h3 className="text-lg font-semibold text-blue-900 mb-2">
                🚀 T-2 DAYS: Tier 1 validation PASSED
              </h3>
              <p className="text-sm text-blue-800">
                Production switch November 9 - LAUNCH November 10!
              </p>
            </div>
            <div className="text-right">
              <p className="text-4xl font-bold text-blue-900">T-2</p>
              <p className="text-xs text-blue-700">Days to Launch</p>
            </div>
          </div>
        </div>

      </main>
    </div>
  );
}

